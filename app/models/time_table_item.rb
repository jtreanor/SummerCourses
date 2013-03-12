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
  # attr_accessible :title, :body
  belongs_to :course
  belongs_to :location
end
