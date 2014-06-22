class TripsController < ApplicationController

  before_action :authenticate_user!

  def new
  end

  def show
  end


  def create
    @trip = current_user.trips.new(trip_params)
    if @trip.save
      redirect_to '/'
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:lat_dest, :lng_dest, :lat_local, :lng_local, :date, :location_start, :location_end, :time, :vehicle, :mpg, :seats_available)
  end
end
