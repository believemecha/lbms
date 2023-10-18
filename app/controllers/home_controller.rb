class HomeController < ApplicationController
    before_action :authenticate_user!, except: :index

    def index
        redirect_to '/home' if current_user.present?
    end

    def home
        redirect_to admin_dashboard_path if current_user.admin?
    end
end