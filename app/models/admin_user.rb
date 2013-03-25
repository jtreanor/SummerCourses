# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  forename               :string(35)       not null
#  surname                :string(35)       not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin_permission_id    :integer
#

class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :admin_permission
  has_one :teacher
  has_many :courses, through: :teacher

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :forename, :surname, :password_confirmation, :remember_me, :admin_permission_id
  # attr_accessible :title, :body

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end
=begin
  def courses
    if self.admin_permission != 'Teacher'
      Course.all
    else
      self.teacher.courses
    end
  end
=end
end
