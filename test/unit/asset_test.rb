# == Schema Information
#
# Table name: assets
#
#  id          :integer          not null, primary key
#  url         :string(255)      not null
#  kind        :string(45)       not null
#  description :string(45)       not null
#

require 'test_helper'

class AssetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
