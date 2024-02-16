class DashboardController < ApplicationController
    before_action :authenticate_user!, except: [:index,:update_status]

    def logs
        redirect_to '/home' if current_user.admin?
      
        # Start with the base query
        @call_logs = CallLog.where(user_id: current_user.id)
      
        # Apply filters
        if params[:start_date].present?
          start_date = Date.parse(params[:start_date])
          @call_logs = @call_logs.where("call_start_time >= ?", start_date.beginning_of_day)
        end
      
        if params[:end_date].present?
          end_date = Date.parse(params[:end_date])
          @call_logs = @call_logs.where("call_start_time <= ?", end_date.end_of_day)
        end
      
        if params[:call_types].present?
          call_types = params[:call_types].split(",")
          @call_logs = @call_logs.where(call_type: call_types)
        end
      
        if params[:phone_number].present?
          @call_logs = @call_logs.where("phone_number LIKE ?", "%#{params[:phone_number]}%")
        end
      
        # Order the results by created_at in descending order
        @call_logs = @call_logs.order(call_start_time: :desc)
      
        # Paginate the results
        @call_logs = Kaminari.paginate_array(@call_logs).page(params[:page]).per(40)
      end
      

    def index
        if !current_user.present?
            redirect_to '/india'
            return
        end

        redirect_to develop_dashboard_index_path if current_user.admin?

        redirect_to '/partner/dashboard' if current_user.partner?

        @call_logs = CallLog.where(user_id: current_user.id)
        @total_calls = @call_logs.count
        @total_duration = @call_logs.sum(:duration)
        @average_duration = @call_logs.average(:duration).to_i
        @longest_call = @call_logs.order(duration: :desc).first

        @summary = @call_logs.group(:name).count.sort_by { |name, count| -count }.select {|name,count| name.present?}

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

    def update_status
      @user = User.last
      @user.update(meta: {date: Time.zone.now.to_s})
    end
end