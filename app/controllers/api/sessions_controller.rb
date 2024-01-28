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

  def login
    user = User.find_by(email: params[:username])

    if user&.valid_password?(params[:password])
      sign_in user
      render json: { message: 'Login successful', user: user, status: true }
    else
      render json: { message: 'Invalid username or Password', status: false, user: nil }
    end
  end


  def signup
    user = User.find_by(email: user_params[:username])

    if user.present?
      render json: { message: 'User with this email already exists', status: false, user:nil, type:"exists" }
    else
      new_user = User.new(email: user_params[:username],password: user_params[:password])

      if new_user.save
        render json: { message: 'Signed Up successfully. Pls check your email for confirmation', user: new_user, status: true, type:"created" }
      else
        render json: { message: "Something Went Wrong! Please try again ", stats: false, user:nil, type:"error" }
      end
    end
  end

  def destroy
    sign_out current_user
    render json: { message: 'Logged out' }
  end

  private

  def user_params
    params.permit(:username, :password, :name)
    # Add any other fields that you need for user creation
  end
end
