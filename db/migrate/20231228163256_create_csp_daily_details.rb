class CreateCspDailyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :csp_daily_details do |t|
      t.string :merchant_id, null: false
      t.integer :user_id, null: false
      t.string :name
      t.decimal :amount, null: false
      t.integer :status
      t.string :code
      t.integer :organization_id
      t.json :meta, default: {}

      t.timestamps
    end
  end
end
