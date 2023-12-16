class RaiseAnIssuesController < ApplicationController
    def index
        @raise_an_issue = RaiseAnIssue.new
      end
    
      def show 
        @raise_an_issue = current_user.raise_an_issues.find_by_id(params[:id])
    
        if !@raise_an_issue.present?
          redirect_to root_path
        end 
      end
    
    
      def new
        @raise_an_issue = RaiseAnIssue.new
      end
      
      def save_report
        @raise_an_issue = RaiseAnIssue.new
       
        @raise_an_issue.user_type = current_user.try(:type)
        @raise_an_issue.user_id = current_user.try(:id)
        @raise_an_issue.email_id = current_user.try(:email)
        @raise_an_issue.phone_number = current_user.try(:phone)
    
        if @raise_an_issue.save
          redirect_to raise_an_issues_path, notice: 'Report submitted successfully.'
        else
          redirect_to root_path, alert: "Failure: #{ @raise_an_issue.errors.full_messages.join(", ") }"
        end
      end
end
