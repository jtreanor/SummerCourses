# == Schema Information
#
# Table name: countries
#
#  country_id :string(2)        primary key
#  country_name :string(45)       not null
#

class Country < ActiveRecord::Base
	attr_accessible :country_name
	set_primary_key :country_id

	has_many :students
end
