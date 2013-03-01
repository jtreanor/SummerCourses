# == Schema Information
#
# Table name: message_threads
#
#  id         :integer          not null, primary key
#  user_email :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
