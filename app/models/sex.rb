# == Schema Information
#
# Table name: sexes
#
#  id      :integer          not null, primary key
#  sexName :string(45)       not null
#

class Sex < ActiveRecord::Base
  # attr_accessible :title, :body
end
