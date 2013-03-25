# == Schema Information
#
# Table name: sexes
#
#  sex_id   :integer          not null, primary key
#  sex_name :string(45)       not null
#

class Sex < ActiveRecord::Base
	attr_accessible :sex_name
	self.primary_key = :sex_id

	has_many :students
end
