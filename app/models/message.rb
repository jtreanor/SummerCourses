class Message < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :thread_id, :timestamp, :subject, :is_response, :message_text
  belongs_to :message_thread
end
