class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email password password_confirmation])
  end
  
  def validate_user!
    return head(:forbidden) unless current_user.present?
  end
end
