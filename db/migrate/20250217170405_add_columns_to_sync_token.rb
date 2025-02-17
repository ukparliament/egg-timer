class AddColumnsToSyncToken < ActiveRecord::Migration[8.0]
  def change
    add_column      :sync_tokens, :google_calendar_name, :text
    add_column      :sync_tokens, :house_id, :integer
    add_foreign_key :sync_tokens, :houses
    add_column      :sync_tokens, :successful, :boolean, default: false
  end
end

