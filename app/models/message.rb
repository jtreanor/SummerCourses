# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  message_thread_id :string(24)       not null
#  subject           :text(255)        default(""), not null
#  is_response       :boolean          default(FALSE), not null
#  content           :text             default(""), not null
#  created_at        :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :message_thread_id, :is_response, :content
  belongs_to :message_thread

end
