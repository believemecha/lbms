# app/controllers/api/sessions_controller.rb
class Api::SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.find_by(email: params[:username])

    if user&.valid_password?(params[:password])
      sign_in user
      render json: { message: 'Login successful', user: user }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    sign_out current_user
    render json: { message: 'Logged out' }
  end
end
