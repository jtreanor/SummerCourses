# == Schema Information
#
# Table name: medium
#
#  id          :integer          not null, primary key
#  url         :string(255)      not null
#  extension   :string(45)       not null
#  description :string(45)       not null
#

require 'test_helper'

class MediaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
