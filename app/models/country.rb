# == Schema Information
#
# Table name: countries
#
#  country_id   :string(2)        primary key
#  country_name :string(45)       not null
#

class Country < ActiveRecord::Base
	attr_accessible :country_name
	self.primary_key = :country_id

	def country_title
		title = self.country_name.downcase  
		title[0] = title.first.capitalize[0]
		title # "Test test"
	end

	has_many :students
end
