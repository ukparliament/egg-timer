# == Schema Information
#
# Table name: detailed_sync_logs
#
#  id            :bigint           not null, primary key
#  calendar_name :text
#  google_calendar_id   :text
#  message       :text
#  successful    :boolean
#  emailed       :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class DetailedSyncLog < ActiveRecord::Base
end
