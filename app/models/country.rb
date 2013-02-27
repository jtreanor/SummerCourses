# == Schema Information
#
# Table name: countries
#
#  countryCode :string(2)
#  countryName :string(45)       not null
#

class Country < ActiveRecord::Base
  # attr_accessible :title, :body
end
