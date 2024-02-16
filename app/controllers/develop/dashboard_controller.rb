class Develop::DashboardController < ApplicationController
    before_action :verify_access

    def index
        # console
        # @users = User.all
    end

    private
    def verify_access
        redirect_to root_path unless current_user && current_user.admin? 
    end
end