# == Schema Information
#
# Table name: refunds
#
#  id         :string(45)       not null, primary key
#  payment_id :string(45)       not null
#

class Refund < ActiveRecord::Base
	attr_accessible :id, :payment_id
	set_primary_key :id

	@transaction_object = nil

	def transaction
		if @transaction_object.nil?
		  @transaction_object = Braintree::Transaction.find(self.id)
		end
		@transaction_object
	end

	belongs_to :payment
	has_one :enrollment, :through => :payment

end
