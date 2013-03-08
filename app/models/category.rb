# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  category_name :string(45)       not null
#

class Category < ActiveRecord::Base
	attr_accessible :category_name
	has_many :courses

	def to_s
		self.category_name
	end

	validates :category_name, presence: true, length: { maximum: 45 }
end
