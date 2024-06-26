ActiveAdmin.register WhatsappTemplate do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :organization_id, :name, :body, :header, :footer, :image_url, :weekday, :send_website_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:organization_id, :name, :body, :header, :footer, :image_url, :weekday, :send_website_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
