# == Schema Information
#
# Table name: payments
#
#  id            :string(10)       not null, primary key
#  enrollment_id :integer          not null
#  amount        :decimal(10, 2)   not null
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
