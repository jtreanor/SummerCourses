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

	def balance_due
		total_paid = self.payments.inject(0) { |sum, e| sum + e.transaction.amount }
		self.course.price - total_paid
	end

	#This calculates the refund entitled in the case of a cancellation. Any payments made before refund_enrollments_before are refunded
	def refund_amount
		total = 0
		self.payments.each do |p|
			if p.transaction.timestamp <= self.course.refund_enrollments_before
				total += p.transaction.amount
			end
		end

		#At a minimum, refund the deposit
		if total == 0
			total = self.course.deposit
		end
		return total
	end

	#returns refundable transactions
	def refund_transactions
		transactions = []
		min_transaction = self.payments[0].transaction
		self.payments.each do |p|
			if p.transaction.timestamp <= self.course.refund_enrollments_before
				transactions << p.transaction
			end
			if p.transaction.amount < min_transaction.amount
				min_transaction = p.transaction
			end
		end

		#Just refund the deposit
		if transactions.empty?
			transactions << min_transaction
		end
		return transactions
	end
end
