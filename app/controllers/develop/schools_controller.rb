class Develop::SchoolsController < ApplicationController
    before_action :verify_access
    layout "develop/main"

    def index
        # console
        # @users = User.all
    end

    def new

    end

    private
    def verify_access
        redirect_to root_path unless current_user && current_user.admin? 
    end
end