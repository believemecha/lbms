module Partners
    class DashboardController < ApplicationController
        before_action :authenticate_user!
        def index
        @child_organizations = current_user.child_organizations
        @current_org = @child_organizations.try(:first)
        @current_org = @child_organizations.find_by(id: params[:org_id]) if @child_organizations.present? && params[:org_id].present?
  
        if @current_org.present?
          @users = @current_org.users
          @user_map = {}
          @users.each do |user|
            @user_map[user.id] = user.first_name
          end 
          puts @user_map

          @user_wise_today_calls = group_call_logs_by_user_and_type(@users.pluck(:id))

          @calls_hash = {}
          @user_wise_today_calls.each do |k,v|
            if @calls_hash[k[0]].present?
                @calls_hash[k[0]][k[1].to_s] = v
            else
                @calls_hash[k[0]] = {}
                @calls_hash[k[0]]["name"] =  @user_map[k[0]]
                @calls_hash[k[0]][k[1].to_s.present? ? k[1].to_s : "declined"] = v
            end
          end
          @stats = @calls_hash.values
          puts @calls_hash
        end
      end
  
      def logs
        # You can use this action to display logs or implement additional functionality.
      end
  
      private
  
      def group_call_logs_by_user_and_type(user_ids)
        CallLog
          .where(user_id: user_ids)
          .group(:user_id, :call_type)
          .count
      end
    end
  end
  