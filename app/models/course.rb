# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  title             :string(100)      not null
#  description       :text             default(""), not null
#  brief_description :text(255)        default(""), not null
#  teacher_id        :integer          not null
#  number_of_places  :integer          not null
#  price             :decimal(10, 2)   not null
#  deposit           :decimal(10, 2)   not null
#  category_id       :integer          not null
#  hits              :integer          default(0), not null
#

class Course < ActiveRecord::Base
	attr_accessible :title, :description, :brief_description, :teacher_id, :number_of_places, :price, :deposit

	belongs_to :category
	has_many :enrollments
end
