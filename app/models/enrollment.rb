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
  # attr_accessible :title, :body
end
