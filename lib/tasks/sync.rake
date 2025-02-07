# NOTE: this script should not be run locally. It uses a sync token from Google to only pull changes from that sync token.

# If there are changes to the Google calendar data and you run this script before it’s run on Heroku, those changes may not not get picked up by the Heroku app.

# Require the syncing code.
#require 'syncing/sync'

# Include syncing code from module.
#include Syncing::GoogleCalendar

require 'google/apis/calendar_v3'
require_relative '../../app/lib/syncing/google/calendar_authorisation'
require_relative '../../app/lib/syncing/google/calendar_pull_events'

include Syncing::Google::CalendarAuthorisation
include Syncing::Google::CalendarPullEvents


task :sync => [
  :sync_commons_sitting_days,
  :sync_lords_sitting_days,
  :sync_lords_virtual_sitting_days,
  :sync_commons_adjournment_days,
  :sync_lords_adjournment_days,
  :sync_commons_recess_dates,
  :sync_lords_recess_dates,
  :record_sync_time
]

task :sync_commons_sitting_days => :environment do
  puts "Syncing commons sitting days"
  sync_sitting_days(COMMONS_SITTING_DAYS_CALENDAR, 1 )
end
task :sync_lords_sitting_days => :environment do
  puts "Syncing lords sitting days"
  sync_sitting_days(LORDS_SITTING_DAYS_CALENDAR, 2 )
end
task :sync_lords_virtual_sitting_days => :environment do
  puts "Syncing lords virtual sitting days"
  sync_virtual_sitting_days(LORDS_VIRTUAL_SITTING_DAYS_CALENDAR, 2 )
end
task :sync_commons_adjournment_days => :environment do
  puts "Syncing commons adjournment days"
  sync_adjournment_days(COMMONS_ADJOURNMENT_DAYS_CALENDAR, 1 )
end
task :sync_lords_adjournment_days => :environment do
  puts "Syncing lords adjournment days"
  sync_adjournment_days(LORDS_ADJOURNMENT_DAYS_CALENDAR , 2 )
end
task :sync_commons_recess_dates => :environment do
  puts "Syncing commons recess dates"
  sync_recess_dates(COMMONS_RECESS_DAYS_CALENDAR , 1 )
end
task :sync_lords_recess_dates => :environment do
  puts "Syncing lords recess dates"
  sync_recess_dates(LORDS_RECESS_DAYS_CALENDAR , 2 )
end
task :record_sync_time => :environment do
  puts "Recording the sync time"
  calendar_sync = CalendarSync.new
  calendar_sync.synced_at = Time.now
  calendar_sync.save!
end