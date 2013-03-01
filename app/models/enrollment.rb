# == Schema Information
#
# Table name: enrollments
#
#  id          :integer          not null, primary key
#  student_id   :integer          not null
#  course_id    :integer          not null
#  is_Cancelled :boolean          default(FALSE), not null
#

class Enrollment < ActiveRecord::Base
	attr_accessible :student_id, :course_id, :is_Cancelled

	def course # getter
  		Course.find_by_id(course_id)
	end

	has_one :course
end
