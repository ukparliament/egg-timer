class CreateSyncLogTable < ActiveRecord::Migration[7.2]
  def change
    create_table :detailed_sync_logs do |t|
      t.text :calendar_name
      t.text :google_calendar_id
      t.text :message
      t.boolean :successful
      t.boolean :emailed
      t.integer :events_count

      t.timestamps
    end
  end
end
