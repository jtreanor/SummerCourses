# == Schema Information
#
# Table name: teachers
#
#  id            :integer          not null, primary key
#  asset_id      :integer
#  is_active     :boolean          default(TRUE), not null
#  description   :text             default(""), not null
#  admin_user_id :integer
#

class Teacher < ActiveRecord::Base
  attr_accessible :asset_id, :is_active, :description, :admin_user_id, :asset_attributes, :admin_user_attributes

  def to_s
    "#{self.admin_user.forename} #{self.admin_user.surname}"
  end

  belongs_to :admin_user
  belongs_to :asset
  has_many :courses

  accepts_nested_attributes_for :asset, :admin_user
  before_create :set_teacher_permission

  private
    def set_teacher_permission
      self.admin_user.admin_permission = AdminPermission.find_by_permission_name 'Teacher'
    end
end
