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
  attr_accessible :title, :description, :brief_description, :allow_refund,
                  :teacher_id, :number_of_places, :price, :deposit, :category_id, :course_assets, :course_assets_attributes, :time_table_items_attributes

  belongs_to :category
  has_many :course_assets
  has_many :assets,
           :through => :course_assets
  has_many :enrollments
  has_many :students,
           :through => :enrollments
  has_many :time_table_items
  belongs_to :teacher
  accepts_nested_attributes_for :course_assets
  accepts_nested_attributes_for :time_table_items

  before_create :set_refund_enrollments_before_to_now

  def set_refund_enrollments_before_to_now
    self.refund_enrollments_before = Time.now
  end

  def start_time
    self.time_table_items.sort_by(&:start_time).last.start_time
  end

  def end_time
    self.time_table_items.sort_by(&:end_time).last.end_time
  end
end
