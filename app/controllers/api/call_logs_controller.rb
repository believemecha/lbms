# app/controllers/api/sessions_controller.rb
class Api::CallLogsController < ApplicationController
    include WebhookHelper
    def update_details
        id = params[:id]
        email = params[:email]
        logs = params[:logs]
        @user = User.find_by(id: id)
        if !@user.present?
            render json: {status: false, message:"Un.....known..."}
            return
        end

        status = true  # Set the status as needed
        UserMailer.send_email(email, status,logs).deliver_now
        render json: {status: true, message:"sent..."}
    end

    def sync_logs
        id = params[:id]
        email = params[:email]
        logs = params[:logs]
        @user = User.find_by(id: id)
        if !@user.present?
            render json: {status: false, message:"Un.....known..."}
            return
        end

        call_logs_data = []
        uid = @user.id
        logs.each do |log|
            call_logs_data << {
              user_id: uid,  # Replace 'User' with your actual User model
              phone_number: log[:number],
              call_start_time: log[:start_time],
              call_end_time: log[:end_time],
              duration: log[:duration],  # Duration in seconds (1 minute to 30 minutes)
              name: log[:name],
              call_type: log[:call_type].downcase
            }
        end
        
        created_till = CallLog.where(user_id: @user.id).order(created_at: :desc).first.try(:created_at)
        if CallLog.insert_all(call_logs_data)
            last_synced = CallLog.where(user_id: @user.id).order(call_start_time: :desc).first
            @user.update(last_synced: last_synced.call_start_time)
            
            if !@user.try(:organization).try(:webhook_url).present?
                render json: {status: true, data: @user}
                return
            end

            logs_created = CallLog.where(user_id: @user.id).where('created_at > ?', created_till.present? ? created_till : Time.now)
            

            payload = []
            logs_created.each  do |log|
                obj = {
                  id: log.id,
                  user: @user.email,
                  phone_number: log.phone_number,
                  start_time: log.call_start_time,
                  end_time: log.call_end_time,
                  duration: log.duration,
                  name: log.name,
                  call_type: log.call_type.try(:downcase),
                  created_at: log.created_at,
                  updated_at: log.updated_at
                }
                payload << obj
            end
            send_log_to_consumer_portal(@user.organization.try(:webhook_url),payload.to_json)
        else
            render json: {status: false, data: nil}
        end
    end 
  end
  

#   {
#   "id": 1, 
#   "email": "user@example.com",
#   "logs": [
#     {
#       "number": "123-456-7890",
#       "start_time": "2023-11-03T08:00:00",
#       "end_time": "2023-11-03T08:30:00",
#       "duration": 1800,  
#       "name": "John Doe"
#     },
#     {
#       "number": "987-654-3210",
#       "start_time": "2023-11-03T09:00:00",
#       "end_time": "2023-11-03T09:15:00",
#       "duration": 900, 
#       "name": "Jane Smith"
#     },
#   ]
# }