# == Schema Information
#
# Table name: message_threads
#
#  id         :string(80)       not null, primary key
#  user_email :string(255)      not null
#  created_at :datetime         not null
#

class MessageThread < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_email
  set_primary_key :id
end
