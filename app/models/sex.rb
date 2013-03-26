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

	def format_name
		title = self.sex_name.downcase  
		title[0] = title.first.capitalize[0]
		title # "Test test"
	end

	has_many :students
end
