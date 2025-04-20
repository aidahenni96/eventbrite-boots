class ApplicationController < ActionController::Base
  before_action :configure_devise_parameters, if: :devise_controller?

  protected

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :is_alive])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :is_alive, :email, :password, :password_confirmation])
  end
end