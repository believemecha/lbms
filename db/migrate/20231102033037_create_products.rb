class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.belongs_to :product_category, foreign_key: true
      t.string :name
      t.text :description
      t.string :image_url
      t.integer :max_price
      t.string :keywords, array: true, default: []
      t.integer :type


      t.timestamps
    end
  end

end
