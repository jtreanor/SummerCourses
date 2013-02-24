# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  categoryName :string(45)       not null
#

class Category < ActiveRecord::Base
	attr_accessible :categoryName

	validates :categoryName, presence: true, length: { maximum: 45 }
end
