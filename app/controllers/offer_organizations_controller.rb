class OfferOrganizationsController < ApplicationController

    def show
        @organization = OfferOrganization.find_by(code: params[:id])
        if @organization.nil?
            redirect_to root_path, alert: "Organization not found" and return
        end
    end

    # GET /offer_organizations/:id/new_student
    def new_student
      @organization = OfferOrganization.find_by(code: params[:id])
  
      if @organization.nil?
        redirect_to root_path, alert: "Organization not found" and return
      end
  
      @student = OfferOrganizationStudent.new
    end
  
    # GET /offer_organizations/:id/students_list
    def students_list
      @organization = OfferOrganization.find_by(code: params[:id])
  
      if @organization.nil?
        redirect_to root_path, alert: "Organization not found" and return
      end
  
      @students = @organization.offer_organization_students
    end
  
    # POST /offer_organizations/:id/students
    def add_student
      organization = OfferOrganization.find_by(code: params[:id])
  
      if organization.nil?
        redirect_to new_student_offer_organization_path(params[:id]), alert: "Organization not found" and return
      end
    
      student = organization.offer_organization_students.new(name: params[:name], image_string: params[:image_string], info: params[:info])
      
      if student.save
        render json: {status: true, message: "Added Successfully"}
      else
        flash.now[:alert] = student.errors.full_messages.to_sentence
        render json: {status: false, message: student.errors.full_messages.to_sentence}
      end
    end

    def scan
        @organization = OfferOrganization.find_by(code: params[:id])
        if @organization.nil?
            redirect_to root_path, alert: "Organization not found" and return
        end
    end

    def capture_scan
        @organization = OfferOrganization.find_by(code: params[:id])
        if @organization.nil?
            return render json: {status: false, message: "Invalid request"}
        end
        qr_data = params[:qr_data].to_s
        result = qr_data.split("::::")
        org_code,student_code = [result.first,result.second]
        
        if org_code != @organization.code
            return render json: {status: false, message: "Invalid Qr"}
        end

        student = OfferOrganizationStudent.find_by(code: student_code)

        if student.nil?
            return render json: {status: false, message: "Invalid Qr"}
        end

        new_record = OfferStudentScan.new(offer_organization_student_id: student.id,offer_organization_id: @organization.id)

        if new_record.save
            return render json: {status: true, message: "Done",student: student}
        else
            return render json: {status: true, message: "Invalid Qr"}
        end
        
    end
end
  