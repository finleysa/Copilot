class ReservationsController < ApplicationController
  before_action :authenticat_user!

  def create
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.save
      redirect_to current_user
  end
end
