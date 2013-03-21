# == Schema Information
#
# Table name: message_threads
#
#  id         :string(24)       not null, primary key
#  user_email :string(255)      not null
#  created_at :datetime         not null
#

class MessageThread < ActiveRecord::Base
  attr_accessible :user_email, :subject, :messages_attributes
  set_primary_key :id

  has_many :messages
  accepts_nested_attributes_for :messages

  def sorted_user_messages
  	self.messages.find_all{|m| !m.is_response }.sort_by{|m| m[:created_at]}
  end

  def most_recent_question
  	self.sorted_user_messages.last.created_at
  end

  def unanswered
  	!self.messages.last.is_response
  end

  def subject_line
  	"Re: #{self.message_thread.subject} [#{self.message_thread.id}]"
  end

end
