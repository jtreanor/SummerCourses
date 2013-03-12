# == Schema Information
#
# Table name: admin_permissions
#
#  id              :integer          not null, primary key
#  permission_name :string(255)
#

class AdminPermission < ActiveRecord::Base
  attr_accessible :permission_name

  def to_s
  	self.permission_name
  end

  has_many :admin_users
end
