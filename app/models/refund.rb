# == Schema Information
#
# Table name: refunds
#
#  id                      :integer          not null, primary key
#  refund_transaction_id   :string(45)       not null
#  original_transaction_id :string(45)       not null
#

class Refund < ActiveRecord::Base
	attr_accessible :refund_transaction_id, :original_transaction_id
end
