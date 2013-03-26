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
  attr_accessible :title, :description, :brief_description, :hits,
                  :teacher_id, :number_of_places, :price, :deposit, :category_id,
                  :images, :course_images, :images_attributes, :course_images_attributes,
                  :videos, :videos_attributes, :course_videos_attributes,
                  :time_table_items_attributes, :refund_enrollments_before,
                  :refund


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

  default_scope :include => :time_table_items, :order => "time_table_items.start_time ASC"

  validates :title, presence: true, length: {maximum: 100}
  validates :description, presence: true
  validates :brief_description, presence: true
  validates :teacher, presence: true
  validates :number_of_places, presence: true, :numericality => {:only_integer => true}
  validates :price, presence: true, :numericality => true
  validates :deposit, presence: true, :numericality => true
  validates :category, presence: true
  validate :have_start_and_end

  def refund
    false
  end

  def have_start_and_end
    self.time_table_items.count >= 1
  end

  def overlaps(course)
    self.time_table_items.each do |tt|
      course.time_table_items.each do |ctt|
        if (ctt.start_time < tt.start_time && ctt.end_time > tt.start_time) ||
            (ctt.start_time > tt.start_time && ctt.end_time < tt.end_time) ||
            (ctt.start_time < tt.end_time && ctt.end_time > tt.end_time)
          return true
        end
      end
    end
    false
  end

  before_create :set_refund_enrollments_before_to_now

  def valid_enrollments
    self.enrollments.find_all { |e| !e.is_cancelled }.count
  end

  def cancellation_count
    self.enrollments.find_all{|e| e.is_cancelled}.count
  end

  def places_remaining
    self.number_of_places - self.valid_enrollments
  end

  def set_refund_enrollments_before_to_now
    self.refund_enrollments_before = Time.now
  end

  def notify_enrollees_of_edit(diff_hash, show_time_table)
    self.enrollments.where(:is_cancelled => false).each do |e|
      CourseMailer.course_changes(diff_hash, e, show_time_table).deliver
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
