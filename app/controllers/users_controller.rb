class UsersController < ApplicationController
before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_reservations = current_user.reservations.map(&:trip)
    @my_trips = Trip.where(user_id: params[:id])
  end

  def remove
  end

end
