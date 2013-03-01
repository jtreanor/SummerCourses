# == Schema Information
#
# Table name: sexes
#
#  sex_id   :integer          primary key
#  sex_name :string(45)       not null
#

class Sex < ActiveRecord::Base
	attr_accessible :sex_name
	set_primary_key :sex_id

	has_many :students
end
