class Trip < ActiveRecord::Base

  has_many :reservations
  has_many :users, :through => :reservations

  default_scope order('date DESC')

  attr_accessible :lat_dest, :lng_dest, :lat_local, :lng_local, :date, :location_start, :location_end, :time, :vehicle, :mpg, :seats_available, :distance,:user_id, :cost

  def delete
  end
end
