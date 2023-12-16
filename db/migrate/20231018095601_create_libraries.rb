class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :location
      t.integer :capacity
      t.text :description
      t.integer :num_staff
      t.integer :num_books
      t.integer :num_members
      t.boolean :offers_membership
      t.boolean :has_cafeteria
      t.boolean :has_meeting_rooms
      t.timestamps
    end
  end
  def down
    drop_table :libraries
  end
end
