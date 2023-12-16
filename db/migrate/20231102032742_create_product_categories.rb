class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.integer :name
      t.text :description
      t.string :keywords, array: true, default: []
      t.timestamps
    end
  end
  
  def down
    drop_table :product_categories
  end
end
