# == Schema Information
#
# Table name: sexes
#
#  sex_id  :integer
#  sexName :string(45)       not null
#

class Sex < ActiveRecord::Base
  # attr_accessible :title, :body
end
