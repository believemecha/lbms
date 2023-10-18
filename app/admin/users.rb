ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :first_name, :last_name, :phone, :country_code

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :country_code
    end
    f.actions
  end
  
end
