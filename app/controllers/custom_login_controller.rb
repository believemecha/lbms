# app/controllers/custom_login_controller.rb
class CustomLoginController < ApplicationController
    before_action :set_user, only: [:generate_otp, :verify_otp]

    def with_otp

    end
  
    def generate_otp
        email = params[:email]
        if email.present?
            if @user.present?
                send_otp(@user.id)
                render json: {status: true}
            else
                render json: {status: false, message: "Please recheck the email."}
            end
        else
            render json: {status: false, message: "Please recheck the email."}
        end
    end
  
    def verify_otp
        otp_entered = params[:otp]
        if @user.present?
          current_otp = UserOtp.find_by(user_id: @user.id,status: :generated,purpose: :login_otp)
          if current_otp.present? && current_otp.otp == otp_entered
            sign_in(User.first)
            render json: {status: true}
          else
            render json: {status: false, message: "Wrong Otp"}
          end
        else
            render json: {status: false, message: "Wrong Otp"}
        end
    end

    def send_otp(id)
        UserMailer.otp(id).deliver_now
    end
      
  
    private
  
    def set_user
      # You may need to set the user based on the email or user ID
      # For demonstration purposes, let's assume the user is identified by the email parameter
      @user = User.find_by(email: params[:email])
    end

  end
  