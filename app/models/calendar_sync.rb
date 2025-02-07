# == Schema Information
#
# Table name: calendar_syncs
#
#  id        :integer          not null, primary key
#  synced_at :datetime         not null
#
class CalendarSync < ActiveRecord::Base
end
