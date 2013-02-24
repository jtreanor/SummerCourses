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
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :forename, :surname, :yearOfBirth , :sexID , :countryCode , :password, :password_confirmation, :remember_me
  has_one :sex
  has_one :country

end
