# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options = {})
    render json: {
      message: "Signed In successfully",
      user: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload["sub"])
    if current_user
      render json: {
        message: "Signed out successfully."
      }, status: :ok
      else
        render json: {
          message: "User has no active session"
        }, status: :unauthorized
    end
  end
end