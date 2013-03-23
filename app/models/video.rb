# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  url         :text             default(""), not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Video < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :description, :url
  has_many :course_videos
  has_many :courses,
           :through => :course_videos

  def to_s
    self.description
  end
end
