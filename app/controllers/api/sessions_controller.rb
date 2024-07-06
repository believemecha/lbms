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
      render json: { message: 'Login successful', user: user, status: true }
    else
      render json: { message: 'Invalid username or Password', status: false, user: nil }
    end
  end

  def update_profile
    user = User.find_by(email: params[:username])
    fcm_token = params[:fcm_token]
    if user.present?
      user.update(fcm_token: fcm_token) if fcm_token.present?
      render json: { message: 'done', status: true }
    else
      render json: { message: 'Invalid User', status: false }
    end
  end

  def check_and_login
    user = User.find_by(email: params[:username])
    if user.present?
      if user&.valid_password?(params[:password])
        render json: { message: 'Login successful', user: user, status: true }
      else
        render json: { message: 'Invalid Credentials',status: false }
      end
    else
      new_user = User.new(email: user_params[:username],password: user_params[:password])
      new_user.last_synced = Time.zone.now - 2.days
      new_user.first_name = user_params[:username].split('@').first
      if new_user.save
        render json: { message: 'Signed Up successfully. Pls check your email for confirmation', user: new_user, status: true }
      else
        render json: { message: "Something Went Wrong! Please try again ", status: false, user:nil }
      end
    end
  end


  def signup
    user = User.find_by(email: user_params[:username])

    if user.present?
      render json: { message: 'User with this email already exists', status: false, user:nil, type:"exists" }
    else
      new_user = User.new(email: user_params[:username],password: user_params[:password])
      new_user.last_synced = Time.zone.now - 2.days
      new_user.first_name = user_params[:username].split('@').first
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


  def request_reset_password
    email = params[:email]
    @user = User.find_by(email: email)
    if email.present?
        if @user.present?
            UserMailer.password_change_otp(@user.id).deliver_now
            render json: {status: true,message: "You will get a otp soon for resetting the password."}
        else
            render json: {status: false, message: "No user found for this email."}
        end
    else
        render json: {status: false, message: "Please recheck the email."}
    end
  end

  def verify_reset_password
      otp_entered = params[:otp]
      password = params[:password]
      @user = User.find_by(email: params[:email])
      if @user.present?
        current_otp = UserOtp.find_by(user_id: @user.id,status: :generated,purpose: :reset_password)
        if current_otp.present? && current_otp.otp == otp_entered
          if @user.update(password: password)
              render json: {status: true,message: "Password Reset successful. Pls Login Now."}
          else
              render json: {status: true,message: @user.errors.full_messages.join(" ")}
          end
        else
          render json: {status: false, message: "Wrong Otp"}
        end
      else
          render json: {status: false, message: "Unauthorised"}
      end
  end

  private

  def user_params
    params.permit(:username, :password, :name)
    # Add any other fields that you need for user creation
  end
end
