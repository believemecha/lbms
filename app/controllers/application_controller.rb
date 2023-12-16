class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?



  def authenticate_admin_user!
    if !current_user.present? || !current_user.admin?
      redirect_to root_path
    end
  end
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :phone_number, :last_name, :user_type, :age, :qualification])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :phone_number, :last_name, :user_type, :age, :qualification])
  end

  def after_sign_in_path_for(resource)
    # Redirect to the desired page after login
    students_path(resource)
  end
  def after_sign_up_path_for(resource)
    # Redirect to the desired page after signup
    # For example, redirect to a welcome page or dashboard
    students_path
  end
  def after_sign_out_path_for(resource_or_scope)
    # Redirect to the desired page after logout
    # For example, redirect to the home page
    root_path
  end



end
