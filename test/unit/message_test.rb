# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  message_thread_id :string(24)       not null
#  is_response       :boolean          default(FALSE), not null
#  content           :text             default(""), not null
#  created_at        :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
