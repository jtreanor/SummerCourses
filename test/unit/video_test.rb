# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  url         :text             default(""), not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
