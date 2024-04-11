class AddAppSessionTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :app_session_token, :text
    add_column :users, :app_session_expires_at, :datetime
    add_column :users, :fcm_token, :text
  end
end
