class MagicLinksController < ApplicationController
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
end
  