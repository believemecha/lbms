class AddWebhookUrlToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :webhook_url, :string
  end
end
