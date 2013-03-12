# == Schema Information
#
# Table name: time_table_items
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  location_id :integer          not null
#  start_time  :datetime         not null
#  end_time    :datetime         not null
#  room        :string(45)       not null
#

require 'test_helper'

class TimeTableItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
