class RenameReceiverTypeToBroadcastType < ActiveRecord::Migration[5.2]
  def change
    rename_column :notification_logs, :receiver_type, :broadcast_type
  end
end
