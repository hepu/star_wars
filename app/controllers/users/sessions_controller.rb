# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix

  respond_to :json
  
  private
  
  def respond_with(current_user, _opts = {})
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
  end
  
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    return head(:ok) if current_user

    head :unauthorized
  end
end
