# == Schema Information
#
# Table name: teachers
#
#  id          :integer          not null, primary key
#  asset_id    :integer
#  is_active   :boolean          default(TRUE), not null
#  description :text             default(""), not null
#  admin_id    :integer
#

class Teacher < ActiveRecord::Base
  # attr_accessible :title, :body
end
