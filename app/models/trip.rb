class Trip < ActiveRecord::Base
  belongs_to :user

  default_scope order('date DESC')

  attr_accessible :lat_dest, :lng_dest, :lat_local, :lng_local, :date, :location_start, :location_end, :time, :vehicle, :mpg, :seats_available, :distance, :cost
  #validates_presence_of :lat_dest, :lng_dest, :lat_local, :lng_local, :date, :location_start, :location_end, :time, :vehicle, :mpg, :seats_available

  def delete
  end
end
