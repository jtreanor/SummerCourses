# == Schema Information
#
# Table name: message_threads
#
#  id         :string(24)       not null, primary key
#  user_email :string(255)      not null
#  subject    :text(255)        default(""), not null
#

require 'test_helper'

class MessageThreadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
