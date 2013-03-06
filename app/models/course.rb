# == Schema Information
#
# Table name: courses
#
#  id                        :integer          not null, primary key
#  title                     :string(100)      not null
#  description               :text             default(""), not null
#  brief_description         :text(255)        default(""), not null
#  teacher_id                :integer          not null
#  number_of_places          :integer          not null
#  price                     :decimal(10, 2)   not null
#  deposit                   :decimal(10, 2)   not null
#  category_id               :integer          not null
#  hits                      :integer          default(0), not null
#  refund_enrollments_before :datetime         not null
#

class Course < ActiveRecord::Base
	attr_accessible :title, :description, :brief_description, :teacher_id, :number_of_places, :price, :deposit

	belongs_to :category
    has_many :course_medium
	has_many :enrollments

	before_create :set_refund_enrollments_before_to_now
  	def set_refund_enrollments_before_to_now
    	self.refund_enrollments_before = Time.now
  	end
end
