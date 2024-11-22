class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :task_id, null: false
      t.string :event_type, null: false
      t.text :details, null: false
      t.timestamps
    end
  end
end
