# == Schema Information
#
# Table name: sync_tokens
#
#  id                   :integer          not null, primary key
#  google_calendar_name :text
#  successful           :boolean          default(FALSE)
#  token                :string(255)      not null
#  google_calendar_id   :string(255)      not null
#  house_id             :integer
#
# Foreign Keys
#
#  fk_rails_...  (house_id => houses.id)
#
class SyncToken < ActiveRecord::Base
end
