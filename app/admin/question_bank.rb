ActiveAdmin.register QuestionBank do
    actions :index, :show, :edit, :new, :update, :create, :destroy

    config.per_page = [10, 50, 100]
  
    scope :all
  
    permit_params :id, :qualification, :stream, :subject, :assigning_on, :question, :solution
  
  
    filter :question
    filter :stream
    filter :subject
    filter :assigning_on
    filter :qualification
    filter :created_at
    filter :updated_at
  
    csv do
      column :id
      column :qualification
      column :stream
      column :subject
      column :question
      column :solution
      column :assigning_on
      column :created_at
      column :updated_at
    end
  
    index do
      id_column
      column :qualification
      column :stream
      column :subject
      column :question
      column :solution
      column :assigning_on
      column :created_at
      column :updated_at
  
      actions
    end
  
    form do |f|
        if f.object.errors.any?
            f.semantic_errors *f.object.errors.keys
        end
            f.inputs 'Question Bank Details' do
            f.input :stream
            f.input :subject
            f.input :question
            f.input :solution
            f.input :assigning_on, as: :datepicker, input_html: { autocomplete: "off" }
            f.input :qualification, as: :select, collection: Student.qualifications.keys.map { |k| [Student.human_attribute_name("qualification_#{k}"), k.to_s] }
          end
          f.actions
    end
   
    show do
        attributes_table do
       row :qualification
       row :stream
       row :subject
       row :question
       row :solution
       row :assigning_on
       row :created_at
       row :updated_at
       
      end
  
      active_admin_comments
    end
   
end
class QuestionBank < ApplicationRecord
  enum qualification: {
    eighth: 8,
    ninth: 9,
    tenth: 10,
    eleventh: 11,
    twelfth: 12
  }

  def self.ransackable_attributes(auth_object = nil)
    ["assigning_on", "created_at", "id", "qualification", "question", "solution", "stream", "subject", "updated_at"]
  end

  belongs_to :user
  end
  