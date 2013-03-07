# == Schema Information
#
# Table name: course_assets
#
#  course_id :integer          not null
#  asset_id  :integer          not null
#

class CourseAsset < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :course_id, :asset_id
  belongs_to :course
  belongs_to :asset
  accepts_nested_attributes_for :asset

end
