# == Schema Information
#
# Table name: course_medium
#
#  course_id :integer          not null
#  media_id  :integer          not null
#

class CourseMedia < ActiveRecord::Base
  # attr_accessible :title, :body
 
  attr_accessible :course_id, :media_id
  belongs_to :course
  belongs_to :media
end
