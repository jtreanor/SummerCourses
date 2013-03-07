class CourseAsset < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :course_id, :asset_id
  belongs_to :course
  belongs_to :asset

end
