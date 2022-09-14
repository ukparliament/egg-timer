class SyncController < ApplicationController
  
  # Require Google calendar api.
  require 'google/apis/calendar_v3'
  
  # Require the syncing code.
  require 'syncing/sync'

  # Include syncing code from module.
  include SYNC
  
  # Sync data from Google calendars
  def sync
    
    # Sync commons sitting days.
    sync_sitting_days( '20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com', 1 )
    
    # Sync lords sitting days.
    sync_sitting_days( 'o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com', 2 )
    
    # Sync lords virtual sitting days.
    sync_virtual_sitting_days( 'p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com', 2 )
    
    # Sync commons adjournment days.
    sync_adjournment_days( 'ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com', 1 )
    
    # Sync lords adjournment days.
    sync_adjournment_days( 'ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com', 2 )
  end
  
  def test
    sync_token = SyncToken.new
    sync_token.google_calendar_id = 'dog'
    sync_token.token = 'cat'
    sync_token.save
    
    @sync_tokens = SyncToken.all
  end
end
