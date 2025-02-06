class SyncLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :sync_logs, id: :serial do |t|
      t.text        :google_calendar_id
      t.text        :calendar_name
      t.boolean     :successful
      t.text        :message

      t.timestamps
    end
  end
end
