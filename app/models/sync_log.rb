# == Schema Information
#
# Table name: sync_logs
#
#  id                 :integer          not null, primary key
#  google_calendar_id :text
#  calendar_name      :text
#  successful         :boolean
#  error_message      :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class SyncLog < ActiveRecord::Base; end
