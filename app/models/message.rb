class Message < ActiveRecord::Base
   attr_accessible :thread_id, :subject, :is_response, :message_textasd, :user_email
  belongs_to :message_thread
   attr_accessible :title, :body

end
