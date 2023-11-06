class CreateWhatsappTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :whatsapp_templates do |t|
      t.belongs_to :organization
      t.string :name
      t.string :body
      t.string :header
      t.string :footer
      t.string :image_url
      t.string :weekday
      t.boolean :send_website_url

      t.timestamps
    end
  end
end
