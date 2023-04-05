# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, options = {})
    if resource.persisted?
      render json: {
        user: resource,
        message: "Account created successfully."
      }, status: :created
      else
        render json: {
          message: "Account could not be created successfully", 
          errors: resource.errors.full_messages
        }, status: :unprocessable_entity
    end
  end
end