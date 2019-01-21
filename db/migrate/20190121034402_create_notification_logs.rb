class CreateNotificationLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_logs, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.uuid :user_id
      t.string :notif_type, null: false
      t.string :event_type, null: false
      # 1 single, 0 multiple
      t.integer :receiver_type, null: false, default: 1
      t.datetime :readed_at
      t.boolean :is_action, null: false, default: false

      t.timestamps
    end
  end
end
