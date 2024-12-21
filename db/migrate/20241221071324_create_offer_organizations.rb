class CreateOfferOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_organizations do |t|

      t.string :name
      t.string :code
      t.text :description
      t.text :icon_image

      t.timestamps
    end
  end
end
