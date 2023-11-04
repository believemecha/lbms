class DashboardController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def logs
        redirect_to '/home' if current_user.admin?
        @call_logs = CallLog.where(user_id: current_user.id).order(created_at: :desc)
        @call_logs = Kaminari.paginate_array(@call_logs).page(params[:page]).per(40)
    end

    def index
        if !current_user.present?
            redirect_to '/india'
            return
        end

        redirect_to '/home' if current_user.admin?

        @call_logs = CallLog.where(user_id: current_user.id)
        @total_calls = @call_logs.count
        @total_duration = @call_logs.sum(:duration)
        @average_duration = @call_logs.average(:duration).to_i
        @longest_call = @call_logs.order(duration: :desc).first
    end

    def log_detail
        @log = CallLog.find_by_id(params[:id])
        redirect_to root_path if !@log.present?
        @phone_number = @log.phone_number  # Get the phone number from the request
        @call_logs = CallLog.where(user_id: current_user.id, phone_number: @phone_number).order(call_start_time: :asc)
        
        # Generate insights specific to the selected phone number
        @total_calls = @call_logs.count
        @total_duration = @call_logs.sum(:duration)
        @average_duration = @call_logs.average(:duration).to_i
        @longest_call = @call_logs.order(duration: :desc).first
        @call_data = @call_logs.pluck(:call_start_time, :duration)

    end
end