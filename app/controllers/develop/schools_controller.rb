class Develop::SchoolsController < ApplicationController
    before_action :verify_access
    layout "develop/main"

    def index
       @schools = School.all
    end

    def new

    end

    def create_new
        school = School.new(name: params[:name],location: params[:location],status: params[:status])
        school.owner_id = current_user.id
        if school.save
          render json: { message: 'School created successfully',status: true }, status: :ok
        else
          render json: { message: school.errors.full_messages, status: false }, status: :ok
        end
    end
      
    private

    def verify_access
        redirect_to root_path unless current_user && current_user.admin? 
    end

end