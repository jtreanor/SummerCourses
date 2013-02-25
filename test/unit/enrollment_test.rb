# == Schema Information
#
# Table name: enrollments
#
#  id          :integer          not null, primary key
#  studentID   :integer          not null
#  courseID    :integer          not null
#  isCancelled :boolean          default(FALSE), not null
#

require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
