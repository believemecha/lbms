class CreateCallLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :call_logs do |t|
      t.belongs_to :user
      t.string :phone_number
      t.datetime :call_start_time
      t.datetime :call_end_time
      t.integer :duration
      t.string :name

      t.timestamps
    end
  end
end
