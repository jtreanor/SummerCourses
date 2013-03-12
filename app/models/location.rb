# == Schema Information
#
# Table name: locations
#
#  id        :integer          not null, primary key
#  title     :string(45)       not null
#  longitude :float            not null
#  latitude  :float            not null
#

class Location < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :time_table_items
end
