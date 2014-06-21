class TripsController < ApplicationController
  def new
  end

  def show
  end


  def create
    @trip = current_user.trips.build(params[:trip])
    if @trip.save
      redirect_to user
    end
  end
end
