# == Schema Information
#
# Table name: countries
#
#  countryCode :integer          not null, primary key
#  countryName :string(45)       not null
#

class Country < ActiveRecord::Base
  # attr_accessible :title, :body
end
