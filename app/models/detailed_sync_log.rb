# == Schema Information
#
# Table name: detailed_sync_logs
#
#  id                 :bigint           not null, primary key
#  calendar_name      :text
#  emailed            :boolean
#  events_count       :integer
#  message            :text
#  successful         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  google_calendar_id :text
#
class DetailedSyncLog < ActiveRecord::Base
end
