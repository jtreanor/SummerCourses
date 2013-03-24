# == Schema Information
#
# Table name: refunds
#
#  id         :string(45)       not null, primary key
#  payment_id :string(45)       not null
#  amount     :decimal(10, 2)   not null
#  created_at :datetime         not null
#

require 'test_helper'

class RefundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
