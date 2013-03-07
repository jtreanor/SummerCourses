# == Schema Information
#
# Table name: assets
#
#  id          :integer          not null, primary key
#  url         :string(255)      not null
#  kind        :string(45)       not null
#  description :string(45)       not null
#

class Asset < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :description, :asset
  has_many :course_assets

  has_attached_file :asset, :styles => { :medium => "600x600>", :thumb => "100x100>" }
end
