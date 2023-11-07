class AddOwnerIdToOrganizations < ActiveRecord::Migration[7.0]
  def change
    add_column :organizations, :owner_id, :integer
  end
end
