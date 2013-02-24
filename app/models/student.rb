# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  forename    :string(35)       not null
#  surname     :string(35)       not null
#  email       :string(255)      not null
#  countryCode :string(2)        not null
#  sexID       :integer          not null
#  password    :string(60)       not null
#  yearOfBirth :integer          not null
#

class Student < ActiveRecord::Base
  attr_accessible :forename, :surname, :email, :password, :yearOfBirth
  has_one :sex
  has_one :country


end
