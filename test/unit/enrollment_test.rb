# == Schema Information
#
# Table name: enrollments
#
#  id           :integer          not null, primary key
#  student_id   :integer          not null
#  course_id    :integer          not null
#  is_cancelled :boolean          default(FALSE), not null
#

require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
