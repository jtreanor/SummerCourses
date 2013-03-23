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
#  is_cancelled              :boolean          default(FALSE), not null
#

class Course < ActiveRecord::Base
  attr_accessible :title, :description, :brief_description,
                  :teacher_id, :number_of_places, :price, :deposit, :category_id, :course_images, :course_images_attributes, :time_table_items_attributes, :videos, :videos_attributes

  belongs_to :category
  has_many :course_images
  has_many :images,
           :through => :course_images
  has_many :course_videos
  has_many :videos,
           :through => :course_videos
  has_many :enrollments
  has_many :students,
           :through => :enrollments
  has_many :time_table_items
  belongs_to :teacher
  accepts_nested_attributes_for :course_images
  accepts_nested_attributes_for :course_videos
  accepts_nested_attributes_for :videos
  accepts_nested_attributes_for :time_table_items


  before_create :set_refund_enrollments_before_to_now

  def set_refund_enrollments_before_to_now
    self.refund_enrollments_before = Time.now
  end

  def start_time
    self.time_table_items.sort_by(&:start_time).first.start_time
  end

  def days_to_start
    now = DateTime.now.beginning_of_day
    start = start_time.beginning_of_day

    #Days until the course starts
    (start-now).to_i/(24*60*60) #Seconds to days
  end

  def end_time
    self.time_table_items.sort_by(&:end_time).last.end_time
  end
end
