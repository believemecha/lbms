ActiveAdmin.register Organization do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :phone_number, :email_address, :website, :whatsapp_number, :address, :logo_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :phone_number, :email_address, :website, :whatsapp_number, :address, :logo_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
