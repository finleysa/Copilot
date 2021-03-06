class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:image, :username, :phone_number, :about_me]
    devise_parameter_sanitizer.for(:account_update) << [:image, :username, :phone_number, :about_me]
  end
end
