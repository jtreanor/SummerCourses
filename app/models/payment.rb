# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  enrollmentID :integer          not null
#

class Payment < ActiveRecord::Base
	attr_accessible :id, :enrollmentID
end
