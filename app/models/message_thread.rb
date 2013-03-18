# == Schema Information
#
# Table name: message_threads
#
#  id         :string(24)       not null, primary key
#  user_email :string(255)      not null
#  created_at :datetime         not null
#

class MessageThread < ActiveRecord::Base
  attr_accessible :user_email, :subject
  set_primary_key :id

  has_many :messages
end
