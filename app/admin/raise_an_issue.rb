ActiveAdmin.register RaiseAnIssue do
  
    actions :index, :show, :edit, :update, :create
  
    config.per_page = [10, 50, 100]
  
    scope :all
  
    permit_params :id, :user_id, :user_type, :phone_number, :email_id, :subject, :description, :status, :acted_by_user_id
  
    filter :user_type
    filter :user_id
    filter :phone_number
    filter :email_id
    filter :description
    filter :status
 
    csv do
      column :id
      column :user_type
      column :user_id
      column :phone_number
      column :email_id
      column :subject
      column :description
      column :status
      column :created_at
      column :updated_at
    end
  
    index do
      id_column
      column :user_id
      column :user_type
      column :phone_number
      column :email_id
      column "subject" do |raise_an_issue|
        truncate(raise_an_issue.try(:subject), length: 70) 
      end 
      column "description" do |raise_an_issue|
        truncate(raise_an_issue.try(:description), length: 70) 
      end      
      column :status
      column :created_at
      column :updated_at
  
      actions
    end
  
    form do |f|
      f.inputs "Raise An Issue" do
        f.input :status, input_html: { required: true }
        f.input :acted_by_user_id, input_html: {value: current_user.try(:id)}, as: :hidden
      end
      f.actions
    end
   
    show do
        attributes_table do
            row :id
            row :user_type
            row :user_id
            row :phone_number
            row :email_id
            row :subject
            row :description
            row :status
            row :created_at
            row :updated_at
       
      end
  
      active_admin_comments
    end
   
  end
  