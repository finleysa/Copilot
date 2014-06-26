class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      trip = Trip.find(@reservation.trip_id)
      trip.seats_available = (trip.seats_available.to_i - 1).to_s
      trip.save!
      redirect_to current_user
    end
  end

  def destroy
    @reservation = Reservation.where(trip_id: params[:id]).where(user_id: current_user.id)
    res_trip = @reservation[0].trip_id
    if @reservation[0].destroy!
      trip = Trip.find(res_trip)
      trip.seats_available = (trip.seats_available.to_i + 1).to_s
      trip.save!
      redirect_to current_user
    end
  end


  private

  def reservation_params
    params.require(:reservation).permit(:trip_id, :user_id)
  end

end
