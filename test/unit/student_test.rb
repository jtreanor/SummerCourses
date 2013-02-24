# == Schema Information
#
# Table name: students
#
#  id          :integer          not null, primary key
#  forename    :string(35)       not null
#  surname     :string(35)       not null
#  email       :string(255)      not null
#  countryCode :string(2)        not null
#  sexID       :integer          not null
#  password    :string(60)       not null
#  yearOfBirth :integer          not null
#

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
