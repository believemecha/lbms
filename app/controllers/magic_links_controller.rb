class MagicLinksController < ApplicationController
  include ApplicationHelper
    def check_link
      code = params[:code]
      @magic_link = MagicLink.find_by(code: code)
  
      if @magic_link.present?
        if @magic_link.expired?
          redirect_to root_path
        else
          user = User.find_by(id: @magic_link.auth_user_id)
          if user.present? && sign_in(user)
            redirect_to @magic_link.redirect_to || "/dashboard", notice: @magic_link.description
          else
            redirect_to root_path, alert: "Failed to sign in with associated user."
          end
        end
      else
        redirect_to root_path, alert: "Invalid magic link."
      end
    end

    def ring_user
      code = params[:code]
      user = User.find_by(email: code)
      duration = params[:duration].to_i || 5
      if user.present? && user.fcm_token.present?
        @response = fcm_push_notification("From web",body="#{Time.zone.now}",duration,user.fcm_token)
      else
        redirect_to root_path, alert: "Invalid magic link."
      end
    end

    def send_text_message
      code = params[:code]
      user = User.find_by(email: code)
      phone = params[:phone]
      message = params[:message]
      if user.present? && user.fcm_token.present?
        @response = fcm_send_message_push_notification(phone,message,user.fcm_token)
      else
        redirect_to root_path, alert: "Invalid magic link."
      end
      render json: {data: @response}
    end
end
  