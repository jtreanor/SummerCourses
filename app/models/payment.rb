# == Schema Information
#
# Table name: payments
#
#  id            :string(10)       not null, primary key
#  enrollment_id :integer          not null
#

class Payment < ActiveRecord::Base
	attr_accessible :id, :enrollment_id
	set_primary_key :id
	after_create :send_receipt

	def send_receipt #Send receipt for most recent payment
		PaymentMailer.payment_receipt(self).deliver
	end

	@transaction_object = nil
	def transaction
		if @transaction_object.nil?
		  @transaction_object = Braintree::Transaction.find(self.id)
		end
		@transaction_object
	end

	def total_refunded
		total = 0
		self.refund.each do |refund|
			total += refund.transaction.amount.to_f
		end
		total
	end

	#Total of payment which has not been refunded
	def total_left
		self.transaction.amount.to_f - self.total_refunded
	end

	#Refund `amount` of this payment
	def refund(amount=total_left)
		result = nil
		if amount < total_left
			result = Braintree::Transaction.refund(transaction.id, amount_to_be_refunded.to_s)
		else #Full refund
			result = Braintree::Transaction.refund(transaction.id)
		end

		if result.success?
			self.refunds.create(id: result.transaction.id)
			puts "Refunded payment #{self.id} to the amount of #{result.transaction.amount}"
			return result.transaction.amount.to_f
		else
			puts "Did not refund payment #{self.id}"
			return 0
		end
	end

	belongs_to :enrollment
	has_many :refunds
end
