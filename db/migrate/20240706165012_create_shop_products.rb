class CreateShopProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :shop_products do |t|
      t.string :title
      t.float :price
      t.text :description
      t.string :category
      t.string :image
      t.jsonb :rating

      t.timestamps
    end
  end
end
