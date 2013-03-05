# == Schema Information
#
# Table name: transactions
#
#  id        :string(10)       not null, primary key
#  amount    :decimal(10, 2)   not null
#  timestamp :datetime         not null
#

class Transaction < ActiveRecord::Base
	attr_accessible :id, :amount, :timestamp
	set_primary_key :id

	has_one :payment
end
