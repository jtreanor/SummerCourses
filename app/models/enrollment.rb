# == Schema Information
#
# Table name: enrollments
#
#  id          :integer          not null, primary key
#  studentID   :integer          not null
#  courseID    :integer          not null
#  isCancelled :boolean          default(FALSE), not null
#

class Enrollment < ActiveRecord::Base
	attr_accessible :studentID, :courseID, :isCancelled

	def course # getter
  		Course.find_by_id(courseID)
	end

	has_one :course
end
