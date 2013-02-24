# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(100)      not null
#  description      :text             default(""), not null
#  briefDescription :text(255)        default(""), not null
#  teacherID        :integer          not null
#  numberOfPlaces   :integer          not null
#  price            :decimal(10, 2)   not null
#  deposit          :decimal(10, 2)   not null
#  categoryID       :integer          not null
#  hits             :integer          default(0), not null
#

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
