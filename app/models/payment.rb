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

	belongs_to :enrollment
	has_many :refunds
end
