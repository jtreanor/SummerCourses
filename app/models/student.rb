# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  forename               :string(35)       not null
#  surname                :string(35)       not null
#  countryCode            :string(2)        not null
#  sexID                  :integer          not null
#  yearOfBirth            :integer          not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

class Student < ActiveRecord::Base
  # Include devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def sexes
    Sex.all
  end

  def countries
    Country.all
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :forename, :surname, :yearOfBirth , :sexID , :countryCode , :password, :password_confirmation, :remember_me
  has_one :sex
  has_one :country

  validates :forename, presence: true, length: { maximum: 35 }
  validates :surname, presence: true, length: { maximum: 35 }
  validates :yearOfBirth, presence: true
  validates :sexID, presence: true
end
