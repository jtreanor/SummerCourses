# == Schema Information
#
# Table name: enrollments
#
#  id              :integer          not null, primary key
#  student_id      :integer          not null
#  course_id       :integer          not null
#  is_cancelled    :boolean          default(FALSE), not null
#  refund_attempts :integer          default(2), not null
#

class Enrollment < ActiveRecord::Base
	attr_accessible :student_id, :course_id, :is_cancelled

	belongs_to :course
	belongs_to :student
	has_many :payments
	has_many :refunds, :through => :payments

	#A reminder of an upcoming course is sent one week and two weeks from the course start.
	def self.send_reminders
		puts "Sending reminder emails."
    	Enrollment.all.find_all{|e| !e.is_cancelled && Time.now <= e.course.start_time && (e.course.days_to_start == 7 || e.course.days_to_start == 14) }.each do |e|
    		puts "Sending reminder email to #{e.student.forename} #{e.student.surname} (#{e.student.email}) regarding #{e.course.title}"
    		CourseMailer.enrollment_reminder(e).deliver
    	end
    	puts "Done"
	end

	#This calculates the refund entitled in the case of a cancellation. Any payments made before refund_enrollments_before are refunded
	def refund_amount
		total = 0

		#Check for special refund entitlement
		self.payments.each do |p|
			if p.created_at <= self.course.refund_enrollments_before
				total += p.amount.to_f
			end
		end

		#At a minimum, refund the total paid in excess of the deposit
		if total == 0
			total = total_paid - self.course.deposit
		end

		return total - total_refunded
	end

	#The total amount which has been refunded for this course.
	def total_refunded
		total = 0
		self.refunds.each do |refund|
			total += refund.amount.to_f
		end

		return total
	end

	def total_paid
		total_paid = 0
		self.payments.each do |p|
			total_paid += p.amount.to_f
		end
		total_paid
	end

	def total_due
		self.course.price - total_paid
	end

	#Returns all enrollments awaiting refund
	def self.refund_queue
		Enrollment.where(:is_cancelled => true).find_all{|e| e.refund_amount > 0 && e.refund_attempts > 0 }
	end

	#class method to processed all queued refunds
	def self.issue_queued_refunds
		enrollments = Enrollment.refund_queue
		puts "#{enrollments.count} refunds queued."

		enrollments.each do |enrollment|
			puts "Starting refund for #{enrollment.student.forename} #{enrollment.student.surname}'s enrollment in #{enrollment.course.title}."
			enrollment.refund
		end
	end

	def refund_failed
		self.refund_attempts -= 1
		self.save
		puts "#{self.refund_attempts} more refund attempts"
		if self.refund_attempts <= 0
			PaymentMailer.refund_failure(self)
		end
	end

	#Called by rake task
	def refund
		to_be_refunded = refund_amount

		puts "To be refunded: #{to_be_refunded}"

		if to_be_refunded <= 0
			puts "Nothing to refund. Done"
			refund_receipt
			return true
		end

		#Check that all payments are settled
		self.payments.each do |payment|
			if payment.transaction.status != "settled"
				puts "Payments not settled."
				refund_failed
				return false
			end
		end

		puts "All payments are settled"

		#All payments are settled, proceed to refund. Starting with highest amount.
		self.payments.sort_by(&:amount).reverse.each do |payment|
			puts "Payment #{payment.id} of which #{payment.total_left} is not refunded."

			if to_be_refunded < payment.total_left
				puts "Attempt partial refund"
				to_be_refunded -= payment.refund(to_be_refunded)
			else
				puts "Attempt full refund"
				to_be_refunded -= payment.refund
			end

			if to_be_refunded <= 0
				puts "Nothing left to refund. Done"
				refund_receipt
				return true
			end

			puts "Left to be refunded: #{to_be_refunded}"
		end

		puts "An error occured when refunding #{self.student.forename} #{self.student.surname}'s enrollment in #{self.course.title}."
		refund_failed
		return false
	end

	def refund_receipt
		PaymentMailer.refund_receipt(self).deliver
	end

	#Cancel course and set refund process in motion
	def cancel
		self.is_cancelled = true
		self.save

		message = "Your cancellation was successful. You have not received a refund."

		if refund_amount > 0
			message = "Your cancellation was successful. You will receive your refund within 48 hours."
		end

		PaymentMailer.refund_processing(self).deliver

		return message
	end
end
