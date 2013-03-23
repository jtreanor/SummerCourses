# == Schema Information
#
# Table name: payments
#
#  id            :string(10)       not null
#  enrollment_id :integer          not null
#

class Payment < ActiveRecord::Base
	attr_accessible :id, :enrollment_id
	set_primary_key :id
	after_create :send_receipt

	def send_receipt #Send receipt for most recent payment
		transaction = Braintree::Transaction.find(self.id)
		PaymentMailer.payment_receipt(self,transaction).deliver
	end

	belongs_to :enrollment
	has_many :refunds
end
