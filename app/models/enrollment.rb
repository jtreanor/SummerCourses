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

	#This calculates the refund entitled in the case of a cancellation. Any payments made before refund_enrollments_before are refunded
	def refund_amount
		total = 0
		self.payments.each do |p|
			transaction = Braintree::Transaction.find(p.transaction_id)
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

	#returns refundable transactions
	def refund_transactions
		transactions = []
		min_transaction = Braintree::Transaction.find(self.payments[0].transaction_id)
		self.payments.each do |p|
			transaction = Braintree::Transaction.find(p.transaction_id)
			if transaction.created_at <= self.course.refund_enrollments_before
				transactions << transaction
			end
			if transaction.amount.to_f < min_transaction.amount
				min_transaction = transaction
			end
		end

		#Just refund the deposit
		if transactions.empty?
			transactions << min_transaction
		end
		return transactions
	end

	def total_paid
		total = 0
		self.payments.each do |p|
			transaction = Braintree::Transaction.find(p.transaction_id)
				total += transaction.amount.to_f
		end
		return total
	end

	def total_due
		self.course.price - total_paid
	end

	def cancel
		refundable_transactions = []
		amount_to_be_refunded = 0;

		min_transaction = Braintree::Transaction.find(self.payments[0].transaction_id)
		self.payments.each do |p|
			transaction = Braintree::Transaction.find(p.transaction_id)
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

		refund_transactions.sort_by(&:amount).each do |transaction|
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
				refund.create(refund_transaction_id: result.transaction_id, original_transaction_id: transaction.id)
				success = true
			else
				message = "An error occured when issuing the refund. Please contact an administrator to un-enroll. The transaction status is: " + transaction.status
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
