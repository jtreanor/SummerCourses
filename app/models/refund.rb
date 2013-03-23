# == Schema Information
#
# Table name: refunds
#
#  id         :integer          not null, primary key
#  payment_id :string(45)       not null
#

class Refund < ActiveRecord::Base
	attr_accessible :id, :payment_id
	set_primary_key :id
	after_create :send_receipt

	def send_receipt
		PaymentMailer.refund_receipt(self).deliver
	end

	belongs_to :payment
	has_one :enrollment, :through => :payment

end
