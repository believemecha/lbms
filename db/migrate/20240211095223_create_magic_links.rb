class CreateMagicLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :magic_links do |t|
      t.integer :link_type
      t.string :redirect_to
      t.string :auth_user_id
      t.string :code
      t.datetime :expires_on
      t.string :description
      t.string :url

      t.timestamps
    end
  end

  def down
    drop_table :magic_links
  end
end
