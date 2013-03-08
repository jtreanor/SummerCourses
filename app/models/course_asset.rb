# == Schema Information
#
# Table name: course_assets
#
#  id        :integer          not null, primary key
#  course_id :integer
#  asset_id  :integer
#

class CourseAsset < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :course_id, :asset_id
  belongs_to :course
  belongs_to :asset
  accepts_nested_attributes_for :asset
end
