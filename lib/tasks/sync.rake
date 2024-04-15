# NOTE: this script should not be run locally. It uses a sync token from Google to only pull changes from that sync token.

# If there are changes to the Google calendar data and you run this script before it’s run on Heroku, those changes may not not get picked up by the Heroku app.

# Require the syncing code.
require 'syncing/sync'

# Include syncing code from module.
include SYNC

require 'google/apis/calendar_v3'

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
  sync_sitting_days( '20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com', 1 )
end
task :sync_lords_sitting_days => :environment do
  puts "Syncing lords sitting days"
  sync_sitting_days( 'o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com', 2 )
end
task :sync_lords_virtual_sitting_days => :environment do
  puts "Syncing lords virtual sitting days"
  sync_virtual_sitting_days( 'p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com', 2 )
end
task :sync_commons_adjournment_days => :environment do
  puts "Syncing commons adjournment days"
  sync_adjournment_days( 'ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com', 1 )
end
task :sync_lords_adjournment_days => :environment do
  puts "Syncing lords adjournment days"
  sync_adjournment_days( 'ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com', 2 )
end
task :sync_commons_recess_dates => :environment do
  puts "Syncing commons recess dates"
  sync_recess_dates( 'eefeb6980f4ee93bd3d486b318141524452c82b8388066ef868e3443a549e3c3@group.calendar.google.com', 1 )
end
task :sync_lords_recess_dates => :environment do
  puts "Syncing lords recess dates"
  sync_recess_dates( '45591a2f31eb089019ba1b200e5ec635f8d25a9620f120e96e881b3165e714d4@group.calendar.google.com', 2 )
end
task :record_sync_time => :environment do
  puts "Recording the sync time"
  calendar_sync = CalendarSync.new
  calendar_sync.synced_at = Time.now
  calendar_sync.save!
end