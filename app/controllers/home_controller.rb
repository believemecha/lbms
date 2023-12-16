class HomeController < ApplicationController
    before_action :authenticate_user!, except: [:index,:india]

    def index
        redirect_to '/india' if !current_user.present?
        redirect_to '/home' if current_user.present?
    end

    def home
        redirect_to admin_dashboard_path if current_user.admin?
        redirect_to '/dashboard' if !current_user.admin?

        @call_logs = CallLog.where(user_id: current_user.id).order(created_at: :desc)
        @call_logs = Kaminari.paginate_array(@call_logs).page(params[:page]).per(40)
    end

    def india
        month_names = ["January", "February", "March", "April", "May"]
        duration_data = [52, 42, 29, 51, 27]
    
        # Create data for the line chart
        @call_data = [
          { name: 'Duration of Calls', data: Hash[month_names.zip(duration_data)] }
        ]

        performers = ["John Smith", "Mary Johnson", "David Williams", "Linda Jones", "Michael Brown", "Patricia Davis", "Robert Miller", "Elizabeth Wilson", "William Moore", "Susan Anderson"]
        call_counts = [500, 600, 750, 850, 450, 700, 550, 950, 800, 700]
    
        @top_performers_data = performers.zip(call_counts)


        lead_sources = ["Website", "Social Media", "Referrals", "Email Campaigns", "Events"]
        lead_counts = [300, 200, 150, 250, 100] # Replace with your actual data
    
        @lead_sources_data = lead_sources.zip(lead_counts)


        sources = ["WhatsApp", "Text Messages", "Emails"]
        auto_reply_counts = [50, 30, 20] # Replace with your actual auto-reply data
    
        @auto_reply_data = sources.zip(auto_reply_counts)
    end
end