class MessageThread < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_email
  has_many :message
end
