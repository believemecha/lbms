class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :location
      t.integer :owner_id
      t.integer :status
      t.json :meta, default: {}

      t.timestamps
    end

    add_foreign_key :schools, :users, column: :owner_id
  end
end
