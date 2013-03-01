# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  enrollment_id :integer          not null
#

class Payment < ActiveRecord::Base
	attr_accessible :id, :enrollment_id

	has_one :enrollment
end
