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

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
