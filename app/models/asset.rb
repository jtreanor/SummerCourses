class Asset < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :url, :description, :kind
  has_many :course_assets
end
