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

class Message < ActiveRecord::Base
  attr_accessible :message_thread_id, :is_response, :content
  after_create :send_email_if_needed
  belongs_to :message_thread

  after_create :send_automated_reply_if_needed

  def send_automated_reply_if_needed
    if message_thread.messages.count == 1
      #First message
      MessageMailer.auto_reply(self).deliver
    end
  end

  #If it is a response, send an email
  def send_email_if_needed
  	if self.is_response
  		logger.info "Send Email"
  		MessageMailer.reply_email( self ).deliver
  	end
  end

  validates :content, presence: true
  validates :message_thread_id, presence: true

end
