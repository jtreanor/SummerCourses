# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  asset_file_name    :string(255)
#  asset_content_type :string(255)
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#  description        :string(45)       not null
#

class Asset < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :description, :asset, :asset_file_name, :asset_attributes
  has_many :course_assets
  has_many :courses,
              :through => :course_assets
  has_many :teachers

  def to_s
  	self.description
  end

  has_attached_file :asset, :styles => { :medium => "600x600>", :thumb => "100x100>", :profile => '400x350>' }
end
