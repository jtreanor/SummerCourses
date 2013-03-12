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
	attr_accessible :asset_id, :is_active, :description, :admin_user_id

	belongs_to :admin_user
	belongs_to :asset
	has_many :courses
end
