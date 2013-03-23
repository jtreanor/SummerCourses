# == Schema Information
#
# Table name: enrollments
#
#  id           :integer          not null, primary key
#  student_id   :integer          not null
#  course_id    :integer          not null
#  is_cancelled :boolean          default(FALSE), not null
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
			transaction = p.transaction
			if transaction.created_at <= self.course.refund_enrollments_before
				total += transaction.amount.to_f
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
			transaction = refund.transaction
			total += transaction.amount.to_f
		end

		return total
	end

	def total_paid
		total_paid = 0
		self.payments.each do |p|
			total_paid += p.transaction.amount.to_f
		end
		total_paid
	end

	def total_due
		self.course.price - total_paid
	end

	#Returns all enrollments awaiting refund
	def self.refund_queue
		Enrollment.where(:is_cancelled => true).find_all{|e| e.refund_amount > 0 }
	end

	#class method to processed all queued refunds
	def self.issue_queued_refunds
		enrollments = Enrollment.refund_queue

		enrollments.each do |enrollment|
			enrollment.refund
		end
	end

	#Called by rake task
	def refund
		to_be_refunded = refund_amount
		if to_be_refunded <= 0
			return true
		end

		#Check that all payments are settled
		self.payments.each do |payment|
			if payment.transaction.status != "settled"
				return false
			end
		end

		#All payments are settled, proceed to refund
		self.payments.each do |payment|
			if to_be_refunded < payment.total_left
				to_be_refunded -= payment.refund(to_be_refunded)
			else
				to_be_refunded -= payment.refund
			end

			if to_be_refunded <= 0
				return true
			end
		end

		return false
	end

	#Cancel course and set refund process in motion
	def cancel
		self.is_cancelled = true
		self.save

		message = "Your cancellation has been processed. You have not received a refund."

		if refund_amount > 0
			message = "Your cancellation has been processed. You will receive your refund within 48 hours."
		end

		PaymentMailer.refund_processing(self).deliver

		return message

	end
end
