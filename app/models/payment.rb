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

	belongs_to :enrollment
	belongs_to :transaction
end
