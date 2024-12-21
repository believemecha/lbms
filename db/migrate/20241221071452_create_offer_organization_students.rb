class CreateOfferOrganizationStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_organization_students do |t|
      t.integer :offer_organization_id
      t.string :name
      t.string :info
      t.text :image_string
      t.string :code
      t.string :qr_code

      t.timestamps
    end
  end
end
