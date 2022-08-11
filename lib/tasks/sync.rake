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
  :sync_lords_adjournment_days
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