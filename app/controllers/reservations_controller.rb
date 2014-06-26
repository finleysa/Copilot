class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      trip = Trip.find(@reservation.trip_id)
      trip.seats_available = (trip.seats_available.to_i - 1).to_s

      if trip.save!
        @twilio_client = Twilio::REST::Client.new 'AC364ef2ccd2c79070943d6644b2d573f8', 'abf7617908903c4830754a8102e0f457'
        @twilio_client.account.sms.messages.create(
          :from => "+16158612408",
          :to => "+16156868516",
          :body => "#{current_user.username} has just joined your trip from #{trip.location_start} to #{trip.location_end} on #{trip.date}"
        )
        redirect_to current_user
      end
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
