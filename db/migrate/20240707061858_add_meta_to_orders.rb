class AddMetaToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :meta, :json, default: {}
    add_column :orders,:payment_status, :string
  end
end
