ActiveAdmin.register Library do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :location, :capacity, :description, :num_staff, :num_books, :num_members, :offers_membership, :has_cafeteria, :has_meeting_rooms
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :location, :description, :num_staff, :num_books, :num_members, :offers_membership, :has_cafeteria, :has_meeting_rooms]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
