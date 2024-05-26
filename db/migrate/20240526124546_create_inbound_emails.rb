class CreateInboundEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :inbound_emails do |t|
      t.json :meta, :json, default: {}
      t.timestamps
    end
  end
end
