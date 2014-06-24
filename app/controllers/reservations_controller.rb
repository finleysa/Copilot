class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to current_user
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :trip_id)
  end

end
