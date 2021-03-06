class TripsController < ApplicationController

  before_action :authenticate_user!
  #before_action :correct_user, only: :destroy

  def index
    @search = Trip.search(params[:q])
    @trips = @search.result
  end

  def create
    @trip = current_user.trips.new(trip_params)
    @trip.starting_seats_available = trip_params[:seats_available]
    if @trip.save
      redirect_to current_user
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy!
    redirect_to current_user
  end

  def reserve
  end

  private

  def trip_params
    params.require(:trip).permit(:lat_dest, :lng_dest, :lat_local, :lng_local, :date, :location_start, :location_end, :time, :vehicle, :mpg, :seats_available, :distance, :user_id, :cost)
  end
end
