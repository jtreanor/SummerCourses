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
                  :teacher_id, :number_of_places, :price, :deposit, :category_id,
                  :images, :course_images, :images_attributes, :course_images_attributes, 
                  :videos, :videos_attributes, :course_videos_attributes,
                  :time_table_items_attributes,:refund_enrollments_before

  #just_define_datetime_picker :refund_enrollments_before, :add_to_attr_accessible => true

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
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :time_table_items


  before_create :set_refund_enrollments_before_to_now


  def set_refund_enrollments_before_to_now
    self.refund_enrollments_before = Time.now
  end

  def notify_enrollees_of_edit(diff_hash, show_time_table)
    self.enrollments.where(:is_cancelled => false).each do |e|
      CourseMailer.course_changes(diff_hash,e,show_time_table).deliver
    end
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

  def cancel
    puts "Cancelling #{self.title}..."
    set_refund_enrollments_before_to_now
    self.is_cancelled = true
    self.save
    self.enrollments.each do |enrollment|
      enrollment.cancel
    end
  end

end
