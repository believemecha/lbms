ActiveAdmin.register CallLog do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :phone_number, :call_start_time, :call_end_time, :duration, :name, :call_type
  #
  # or
  #
  actions :index,:show

  # permit_params do
  #   permitted = [:user_id, :phone_number, :call_start_time, :call_end_time, :duration, :name, :call_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
