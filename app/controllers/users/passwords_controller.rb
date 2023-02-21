# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  include RackSessionsFix

  respond_to :json
  
  def create
    # Check if user exists
    user = User.find_by!(email: user_params[:email])
    
    # Reset password for user
    token = user.send_reset_password_instructions

    if successfully_sent?(user)
      render json: { reset_password_token: token }
    else
      Rails.logger.debug("[Users::PasswordsController]: Error sending email to user")
      head(:unprocessable_entity)
    end
  rescue StandardError => e
    Rails.logger.debug("[Users::PasswordsController]: Error: #{e.message}")
    head(:unprocessable_entity)
  end
  
  def update; super; end
  
  private
  
  def user_params
    params.require(:user).permit(:email)
  end
end
