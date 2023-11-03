class DashboardController < ApplicationController
    before_action :authenticate_user!

    def logs
        redirect_to '/home' if current_user.admin?
        @call_logs = CallLog.where(user_id: current_user.id).order(created_at: :desc)
        @call_logs = Kaminari.paginate_array(@call_logs).page(params[:page]).per(40)
    end

    def index
        redirect_to '/home' if current_user.admin?
        
        @call_logs = CallLog.where(user_id: current_user.id)
        # Generate insights
        @total_calls = @call_logs.count
        @total_duration = @call_logs.sum(:duration)
        @average_duration = @call_logs.average(:duration).to_i
        @longest_call = @call_logs.order(duration: :desc).first
    end
end