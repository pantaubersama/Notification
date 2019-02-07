class CreatePemiluBroadcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :pemilu_broadcasts, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :event_type

      t.timestamps
    end
  end
end
