# == Schema Information
#
# Table name: medium
#
#  id          :integer          not null, primary key
#  url         :string(255)      not null
#  extension   :string(45)       not null
#  description :string(45)       not null
#

class Media < ActiveRecord::Base
  # attr_accessible :title, :body
  #

  attr_accessible :url, :description, :extension
  belongs_to :course_media

end
