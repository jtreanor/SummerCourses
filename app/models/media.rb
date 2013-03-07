# == Schema Information
#
# Table name: medium
#
#  id          :integer          not null, primary key
#  url         :string(255)      not null
#  kind        :string(45)       not null
#  description :string(45)       not null
#

class Media < ActiveRecord::Base
  # attr_accessible :title, :body
  #

  attr_accessible :url, :description, :kind
  has_many :course_medium

end
