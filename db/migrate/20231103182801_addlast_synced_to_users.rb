class AddlastSyncedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_synced, :datetime
  end
end
