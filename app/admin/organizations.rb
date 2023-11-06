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
  show do
    attributes_table do
      row :name
      row :phone_number
      row :email_address
      row :website
      row :whatsapp_number
      row :address
      row :logo_url
    end

    panel "Users in this Organization" do
      all_logs = CallLog.where(user_id: organization.users.pluck(:id)).group(:user_id).count
      table_for organization.users do
        column :id
        column :first_name
        column :last_name
        column :email
        column "Total Logs" do |u|
          all_logs[u.id]
        end
        # Add more columns as needed to display user information
      end
    end

    panel "Whatsapp Templates" do
      table_for organization.whatsapp_templates do
        column :name
        column :weekday
        column :body
        column :header
        column :footer
        column :image_url
        column :send_website_url

        # Add more columns as needed to display user information
      end
    end
  end

end
