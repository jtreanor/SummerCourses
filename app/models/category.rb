# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  categoryName :string(45)       not null
#

class Category < ActiveRecord::Base
	attr_accessible :categoryName
	has_many :courses

	validates :categoryName, presence: true, length: { maximum: 45 }
end
