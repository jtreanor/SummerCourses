# == Schema Information
#
# Table name: students
#
#  id                     :integer          not null, primary key
#  forename               :string(35)       not null
#  surname                :string(35)       not null
#  country_id             :string(2)        not null
#  sex_id                 :integer          not null
#  year_of_birth          :integer          not null
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

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :forename, :surname, :year_of_birth, :password, :password_confirmation, :remember_me, :sex_id, :country_id
  belongs_to :sex
  belongs_to :country
  has_many :enrollments
  has_many :courses,
              :through => :enrollments

  def self.send_course_reminders
    
  end

  def self.send_payment_reminders

  end

  validates :forename, presence: true, length: { maximum: 35 }
  validates :surname, presence: true, length: { maximum: 35 }
  validates :year_of_birth, presence: true
  validates :sex_id, presence: true
end
