# app/controllers/api/sessions_controller.rb
class Api::CallLogsController < ApplicationController
    protect_from_forgery with: :null_session

    def update_details
        id = params[:id]
        email = params[:email]
        logs = params[:logs]
        @user = User.find_by(id: id)
        if !@user.present?
            render json: {status: false, message:"Un.....known..."}
            return
        end

        status = true  # Set the status as needed
        UserMailer.send_email(email, status,logs).deliver_now
        render json: {status: true, message:"sent..."}
    end
  end
  