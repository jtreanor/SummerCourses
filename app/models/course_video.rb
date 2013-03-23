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
end
