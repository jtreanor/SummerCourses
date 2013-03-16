# == Schema Information
#
# Table name: locations
#
#  id        :integer          not null, primary key
#  title     :string(45)       not null
#  longitude :float            not null
#  latitude  :float            not null
#  gmaps     :boolean          default(TRUE), not null
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
