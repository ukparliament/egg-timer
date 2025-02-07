# == Schema Information
#
# Table name: sync_tokens
#
#  id                 :integer          not null, primary key
#  google_calendar_id :string(255)      not null
#  token              :string(255)      not null
#
class SyncToken < ActiveRecord::Base
end
