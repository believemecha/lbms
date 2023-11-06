class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :phone_number
      t.string :email_address
      t.string :website
      t.string :whatsapp_number
      t.string :address
      t.string :logo_url

      t.timestamps
    end
  end
end
