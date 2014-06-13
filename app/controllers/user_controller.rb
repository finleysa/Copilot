class UserController < ApplicationController

  def show
    @user = User.find(
  end
end
