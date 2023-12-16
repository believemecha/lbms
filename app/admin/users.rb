ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :first_name, :last_name, :user_type, :age, :phone_number, :qualification, :stream, :address, :school_name, :country, :dob, :interested_program, :score, :admission_taken, :school_address, :area_of_interest, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :qualification
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :first_name, :last_name, :user_type, :age, :phone_number, :qualification, :stream, :address, :school_name, :country, :dob, :interested_program, :score, :admission_taken, :school_address, :area_of_interest, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :qualification]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
