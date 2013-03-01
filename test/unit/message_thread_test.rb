# == Schema Information
#
# Table name: message_threads
#
#  id         :integer          not null, primary key
#  user_email :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MessageThreadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
