class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.belongs_to :user
      t.string :title
      t.string :slug
      t.text :content
      t.timestamps
    end
  end
end
