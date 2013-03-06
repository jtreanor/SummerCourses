# == Schema Information
#
# Table name: course_medium
#
#  course_id :integer          not null
#  media_id  :integer          not null
#

class CourseMedia < ActiveRecord::Base
  # attr_accessible :title, :body
  
  has_many :course
  has_many :media
end
