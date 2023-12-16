class AddCallTypeToCallLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :call_logs, :call_type, :integer
  end
end
