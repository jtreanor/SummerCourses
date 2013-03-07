# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  message_thread_id :string(80)       not null
#  subject           :text(255)        default(""), not null
#  is_response       :boolean          default(FALSE), not null
#  content           :text             default(""), not null
#  created_at        :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :message_thread_id, :subject, :is_response, :content
  belongs_to :message_thread
  attr_accessible :title, :body
end
