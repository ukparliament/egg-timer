class SyncController < ApplicationController
  
  # Include syncing code from module.
  include Syncing::Google::Calendar
  
  # Sync data from Google calendars
  def sync
    # Sync commons sitting days.
    sync_sitting_days(COMMONS_SITTING_DAYS_CALENDAR, 1 )
    
    # Sync lords sitting days.
    sync_sitting_days(LORDS_SITTING_DAYS_CALENDAR, 2 )
    
    # Sync lords virtual sitting days.
    sync_virtual_sitting_days(LORDS_VIRTUAL_SITTING_DAYS_CALENDAR, 2 )
    
    # Sync commons adjournment days.
    sync_adjournment_days(COMMONS_ADJOURNMENT_DAYS_CALENDAR, 1 )
    
    # Sync lords adjournment days.
    sync_adjournment_days(LORDS_ADJOURNMENT_DAYS_CALENDAR, 2 )
  end
  
  def test
    sync_token = SyncToken.new
    sync_token.google_calendar_id = 'dog'
    sync_token.token = 'cat'
    sync_token.save
    
    @sync_tokens = SyncToken.all
  end
end
