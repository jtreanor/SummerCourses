# == Schema Information
#
# Table name: refunds
#
#  id                      :integer          not null, primary key
#  refund_transaction_id   :string(45)       not null
#  original_transaction_id :string(45)       not null
#

require 'test_helper'

class RefundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
