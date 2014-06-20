class TripsController < ApplicationController
  def new
  end

  def show
  end


  def create
    @trip = current_user.trips.build(trip_params)
  end

  private

    def trips_params
      trips.require(:trip).permit(:location_start, :location_end)
    end
end
