ActiveAdmin.register MagicLink do

  permit_params :link_type, :redirect_to, :auth_user_id, :code, :expires_on, :description, :url

  form do |f|

    f.inputs "Magic Link Details" do
      f.input :link_type, as: :select, collection: MagicLink.link_types.keys
      f.input :auth_user_id, label: "Auth User", as: :select, collection: User.all.map { |u| [u.email, u.id] }
      f.input :redirect_to
      f.input :description
      f.input :expires_on, as: :datepicker
    end
    
    f.actions
  end
  
end
