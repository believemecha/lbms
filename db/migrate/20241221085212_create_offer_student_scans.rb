class CreateOfferStudentScans < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_student_scans do |t|
      t.integer :offer_organization_student_id
      t.integer :offer_organization_id
      
      t.timestamps
    end
  end
end
