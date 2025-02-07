# NOTE: this script should not be run locally. It uses a sync token from Google to only pull changes from that sync token.

# If there are changes to the Google calendar data and you run this script before it’s run on Heroku, those changes may not not get picked up by the Heroku app.

# Require the syncing code.
#require 'syncing/sync'

# Include syncing code from module.
#include Syncing::GoogleCalendar

require 'google/apis/calendar_v3'
require_relative '../../app/lib/syncing/google_calendar'
include Syncing::GoogleCalendar

### PRoduction
COMMONS_SITTING_DAYS_CALENDAR='20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com'
LORDS_SITTING_DAYS_CALENDAR='o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com'
LORDS_VIRTUAL_SITTING_DAYS_CALENDAR='p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com'
COMMONS_ADJOURNMENT_DAYS_CALENDAR='ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com'
LORDS_ADJOURNMENT_DAYS_CALENDAR='ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com'
COMMONS_RECESS_DAYS_CALENDAR='eefeb6980f4ee93bd3d486b318141524452c82b8388066ef868e3443a549e3c3@group.calendar.google.com'
LORDS_RECESS_DAYS_CALENDAR='45591a2f31eb089019ba1b200e5ec635f8d25a9620f120e96e881b3165e714d4@group.calendar.google.com'

# Test
# COMMONS_SITTING_DAYS_CALENDAR="08c47a45c4ad926a2ed5690d5de6664ec4ed5f25ee77e3cbab1bd2b3b54cd804@group.calendar.google.com"
# LORDS_SITTING_DAYS_CALENDAR="321431db1e84f9c1743f5b1c3291a1544fbda486f8ccc2d1a021b448598de92e@group.calendar.google.com"
# LORDS_VIRTUAL_SITTING_DAYS_CALENDAR="902c32b23639d887c56c9a2cef82c9d0dc352d3e5967bc4806062dbf917920d5@group.calendar.google.com"
# COMMONS_ADJOURNMENT_DAYS_CALENDAR="9dc2afe4c49604de9a88e836449a49a90356e2796f626d5aa896fc6f64c6fab8@group.calendar.google.com"
# LORDS_ADJOURNMENT_DAYS_CALENDAR="d3333dda8d0fc131f470bc145c5d6b9fedc9a449827fc3dcf485290ce123819b@group.calendar.google.com"
# COMMONS_RECESS_DAYS_CALENDAR="c168720cd26912a9f1f872e5c87d41809b5ffd0ec08194c23bf9ceca17b8f043@group.calendar.google.com"
# LORDS_RECESS_DAYS_CALENDAR="843571d922480c5de55c8a354e31eb59061a58b11ff9fca2b8bd154a62bf7b92@group.calendar.google.com"


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