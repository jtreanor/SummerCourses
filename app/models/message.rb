class Message < ActiveRecord::Base
  attr_accessible :message_thread_id, :subject, :is_response, :content
  belongs_to :message_thread
  attr_accessible :title, :body
end
