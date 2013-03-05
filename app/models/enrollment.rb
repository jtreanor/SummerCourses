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

	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = "6b6c6smqn4ddbrvy"
	Braintree::Configuration.public_key = "bkmz9ztnjt6f3jvj"
	Braintree::Configuration.private_key = "e37569f722592948d8e9e262fec86478"

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
		
	end
end
