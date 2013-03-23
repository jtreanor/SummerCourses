# == Schema Information
#
# Table name: course_videos
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  video_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseVideo < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :course_id, :video_id, :video_attributes
  belongs_to :course
  belongs_to :video
  accepts_nested_attributes_for :video
end
