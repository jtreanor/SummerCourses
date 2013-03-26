# == Schema Information
#
# Table name: time_table_items
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  location_id :integer          not null
#  start_time  :datetime         not null
#  end_time    :datetime         not null
#  room        :string(45)       not null
#

class TimeTableItem < ActiveRecord::Base
  attr_accessible :location_id, :start_time, :end_time, :room
  just_define_datetime_picker :start_time, :add_to_attr_accessible => true
  just_define_datetime_picker :end_time, :add_to_attr_accessible => true
  belongs_to :course
  belongs_to :location

  default_scope order: 'time_table_items.start_time ASC'

  validates :course_id, presence: true
  validates :location_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
