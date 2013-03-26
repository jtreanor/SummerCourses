# == Schema Information
#
# Table name: locations
#
#  id        :integer          not null, primary key
#  title     :string(45)       not null
#  longitude :float            not null
#  latitude  :float            not null
#  gmaps     :boolean          default(TRUE), not null
#

class Location < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :longitude, :latitude, :title
  acts_as_gmappable

  has_many :time_table_items

  validates :title, presence: true, length: { maximum: 45 }
  validates :longitude, presence: true, :numericality => true
  validates :latitude, presence: true, :numericality => true

#  def gmaps4rails_address
#    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
#    "#{self.street}, #{self.city}, #{self.country}"
#  end
end
