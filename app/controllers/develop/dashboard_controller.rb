class Develop::DashboardController < ApplicationController
    before_action :verify_access
    layout "develop/main"

    def index
        # console
        # @users = User.all
    end

    def stats

    end

    private
    def verify_access
        redirect_to root_path unless current_user && current_user.admin? 
    end
end