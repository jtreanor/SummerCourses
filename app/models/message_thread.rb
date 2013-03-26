# == Schema Information
#
# Table name: message_threads
#
#  id         :string(24)       not null, primary key
#  user_email :string(255)      not null
#  subject    :text(255)        default(""), not null
#

class MessageThread < ActiveRecord::Base
  attr_accessible :user_email, :subject, :messages_attributes
  self.primary_key = :id
  before_create :generate_id

  has_many :messages
  accepts_nested_attributes_for :messages

  default_scope :include => :messages, :order => "messages.created_at DESC"

  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates :user_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :subject, presence: true

  def generate_id
    self.id = SecureRandom.urlsafe_base64(6) 

    while MessageThread.find_by_id self.id
      self.id = SecureRandom.urlsafe_base64(6)
    end
  end

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
  	"Re: #{self.subject} [#{self.id}]"
  end

end
