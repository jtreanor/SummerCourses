# == Schema Information
#
# Table name: transactions
#
#  id        :integer          not null, primary key
#  amount    :decimal(10, 2)   not null
#  timestamp :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
