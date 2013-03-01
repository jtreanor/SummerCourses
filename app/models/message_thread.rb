class MessageThread < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_email
  
=begin 
  def get_message
    @message
  end

  def set_message (new_message)
    @message = new_message
  end

  has_many :message
=end
end
