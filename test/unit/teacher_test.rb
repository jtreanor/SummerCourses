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

require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end