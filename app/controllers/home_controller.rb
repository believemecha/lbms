class HomeController < ApplicationController
    before_action :authenticate_user!, except: :index

    def index
        redirect_to '/home' if current_user.present?
    end

    def home
        redirect_to admin_dashboard_path if current_user.admin?
        redirect_to '/dashboard' if !current_user.admin?

        @call_logs = CallLog.where(user_id: current_user.id).order(created_at: :desc)
        @call_logs = Kaminari.paginate_array(@call_logs).page(params[:page]).per(40)
    end
end