# == Schema Information
#
# Table name: payments
#
#  transaction_id :string(10)       not null, primary key
#  enrollment_id  :integer          not null
#

class Payment < ActiveRecord::Base
	attr_accessible :transaction_id, :enrollment_id
	set_primary_key :transaction_id
	after_create :send_receipt

	def send_receipt #Send receipt fro most recent payment
		transaction = Braintree::Transaction.find(self.transaction_id)
		PaymentMailer.payment_receipt(self,transaction).deliver
	end

	belongs_to :enrollment
end
