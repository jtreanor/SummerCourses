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
		self.payments.each do |p|
			transaction = p.transaction
			if transaction.created_at <= self.course.refund_enrollments_before
				total += transaction.amount.to_f
			end
		end

		#At a minimum, refund the deposit
		if total == 0
			total = self.course.deposit
		end
		return total
	end

	def total_paid
		total = 0
		self.payments.each do |p|
			total += p.transaction.amount.to_f
		end
		return total
	end

	def total_due
		self.course.price - total_paid
	end

	def total_refunded
		total = 0
		self.payments.each do |p|
			Refund.find_all_by_id(p.id).each do |refund|
				transaction = refund.transaction
				total += transaction.amount.to_f
			end
		end

		return total
	end

	#Cancel course and refund appropriate amount
	def cancel
		refundable_transactions = []
		amount_to_be_refunded = 0;

		min_transaction = self.payments.first.transaction
		self.payments.each do |p|
			transaction = p.transaction
			if transaction.created_at <= self.course.refund_enrollments_before
				refundable_transactions << transaction
				amount_to_be_refunded += transaction.amount.to_f
			end
			if transaction.amount.to_f < min_transaction.amount
				min_transaction = transaction
			end
		end

		#Just refund the deposit
		if refundable_transactions.empty?
			refundable_transactions << min_transaction
			amount_to_be_refunded = self.course.deposit
		end

		success = false
		message = "An error occured when issuing the refund. Please contact an administrator to un-enroll."

		refundable_transactions.sort_by(&:amount).each do |transaction|
			result = nil

			if transaction.amount.to_f > amount_to_be_refunded
				result = Braintree::Transaction.refund(transaction.id, amount_to_be_refunded.to_s)
				amount_to_be_refunded = 0
			else
				result = Braintree::Transaction.refund(transaction.id)
				amount_to_be_refunded -= transaction.amount.to_f
			end
			if result.success?
				message = "The refund was succesfully applied."
				Refund.create(id: result.transaction.id, payment_id: transaction.id)
				success = true
			else
				message = "An error occured when issuing the refund. Please contact an administrator to un-enroll. " + result.message
				success = false
				break
			end
		end

		if success
			self.is_cancelled = true
			self.save
		end

		return message

	end
end
