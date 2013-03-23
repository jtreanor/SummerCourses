# == Schema Information
#
# Table name: course_images
#
#  id        :integer          not null, primary key
#  course_id :integer
#  image_id  :integer
#

class CourseImage < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :course_id, :image_id, :image_attributes
  belongs_to :course
  belongs_to :image
  accepts_nested_attributes_for :image
end
