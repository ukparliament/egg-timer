# NOTE: this script should not be run locally. It uses a sync token from Google to only pull changes from that sync token.

# If there are changes to the Google calendar data and you run this script before it’s run on Heroku, those changes may not not get picked up by the Heroku app.




require 'google/apis/calendar_v3'

task :sync => [
  :sync_commons_sitting_days,
  :sync_lords_sitting_days,
  :sync_lords_virtual_sitting_days,
  :sync_commons_adjournment_days,
  :sync_lords_adjournment_days
]



task :sync_commons_sitting_days => :environment do
  puts "syncing commons sitting days"
  sync_sitting_days( '20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com', 1 )
end
task :sync_lords_sitting_days => :environment do
  puts "syncing lords sitting days"
  sync_sitting_days( 'o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com', 2 )
end
task :sync_lords_virtual_sitting_days => :environment do
  puts "syncing lords virtual sitting days"
  sync_virtual_sitting_days( 'p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com', 2 )
end
task :sync_commons_adjournment_days => :environment do
  puts "syncing commons adjournment days"
  sync_adjournment_days( 'ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com', 1 )
end
task :sync_lords_adjournment_days => :environment do
  puts "syncing lords adjournment days"
  sync_adjournment_days( 'ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com', 2 )
end



def sync_sitting_days( calendar_id, house_id )
  
  # authorise to grab events from google calendar
  service = authorise_calendar_access
  
  # get any changed events from the calendar
  response = get_changed_events_from_calendar( service, calendar_id )
  
  # loop through all changed events
  response.items.each do |event|
    if event.status == 'cancelled'
      delete_sitting_days( event.id )
    elsif event.status == 'confirmed'
      # if this is an edit (has it been updated since created) delete it's previous incarnation
      delete_sitting_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes
      
      # create (new) sitting day
      puts "creating event #{event.id}"
      start_date = ( event.start.date || event.start.date_time ).to_date
      end_date = ( event.end.date || event.end.date_time ).to_date
      
      # because all day appointments end at midnight the next day subtract a day if there's no end datetime
      end_date = end_date - 1.day unless event.end.date_time
      
      # find the session this event is in
      # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session
      session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first
      unless session
        
        # find the session that's not yet ended if the event isn't in a different session
        session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
      end
      if session
        sitting_day = SittingDay.new
        sitting_day.start_date = start_date
        sitting_day.end_date = end_date
        sitting_day.google_event_id = event.id
        sitting_day.session = session
        sitting_day.house_id = house_id
        sitting_day.save
      end
    end
  end
end

def sync_virtual_sitting_days( calendar_id, house_id )
  
  # authorise to grab events from google calendar
  service = authorise_calendar_access
  
  # get any changed events from the calendar
  response = get_changed_events_from_calendar( service, calendar_id )
  
  # loop through all changed events
  response.items.each do |event|
    if event.status == 'cancelled'
      delete_virtual_sitting_days( event.id )
    elsif event.status == 'confirmed'
      # if this is an edit (has it been updated since created) delete it's previous incarnation
      delete_virtual_sitting_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes
      
      # create (new) virtual sitting day
      puts "creating event #{event.id}"
      start_date = ( event.start.date || event.start.date_time ).to_date
      end_date = ( event.end.date || event.end.date_time ).to_date
      
      # because all day appointments end at midnight the next day subtract a day if there's no end datetime
      end_date = end_date - 1.day unless event.end.date_time
      
      # find the session this event is in
      # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session
      session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first
      unless session
        
        # find the session that's not yet ended if the event isn't in a different session
        session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
      end
      if session
        virtual_sitting_day = VirtualSittingDay.new
        virtual_sitting_day.start_date = start_date
        virtual_sitting_day.end_date = end_date
        virtual_sitting_day.google_event_id = event.id
        virtual_sitting_day.session = session
        virtual_sitting_day.house_id = house_id
        virtual_sitting_day.save
      end
    end
  end
end

def sync_adjournment_days( calendar_id, house_id )
  
  # authorise to grab events from google calendar
  service = authorise_calendar_access
  
  # get any changed events from the calendar
  response = get_changed_events_from_calendar( service, calendar_id )
  
  # loop through all changed events
  response.items.each do |event|
    if event.status == 'cancelled'
      delete_adjournment_days( event.id )
    elsif event.status == 'confirmed'
      # if this is an edit (has it been updated since created) delete it's previous incarnation
      delete_adjournment_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes
      
      # create (new) adjournment days
      puts "creating event #{event.id}"
      start_date = ( event.start.date || event.start.date_time ).to_date
      end_date = ( event.end.date || event.end.date_time ).to_date
      
      # because all day appointments end at midnight the next day subtract a day if there's no end datetime
      end_date = end_date - 1.day unless event.end.date_time
      
      # loop through all the dates covered and created an adjournment day for each
      (start_date..end_date).each do |date|
      
        # find the session this event is in
        session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first
        unless session
          
          # find the session that's not yet ended if the event isn't in a different session
          session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
        end
        if session
          adjournment_day = AdjournmentDay.new
          adjournment_day.date = date
          adjournment_day.google_event_id = event.id
          adjournment_day.session = session
          adjournment_day.house_id = house_id
          adjournment_day.save
        end
      end
    end
  end
end

# delete any adjournment days with a given event id
def delete_adjournment_days( event_id )
  puts "deleting event #{event_id}"
  # adjournment day deletions
  adjournment_days = AdjournmentDay.all.where( "google_event_id = ?", event_id )
  adjournment_days.each do |adjournment_day|
    adjournment_day.destroy
  end
end

# delete any sitting days with a given event id
def delete_sitting_days( event_id )
  puts "deleting event #{event_id}"
  sitting_day = SittingDay.all.where( "google_event_id = ?", event_id ).first
  sitting_day.destroy if sitting_day
end

# delete any virtual sitting days with a given event id
def delete_virtual_sitting_days( event_id )
  puts "deleting event #{event_id}"
  virtual_sitting_day = VirtualSittingDay.all.where( "google_event_id = ?", event_id ).first
  virtual_sitting_day.destroy if virtual_sitting_day
end

# Get a list of changed events from a calendar (created, updated and deleted)
def get_changed_events_from_calendar( service, calendar_id )
  sync_token = SyncToken.find_by_google_calendar_id( calendar_id )
  if sync_token
    response = service.list_events(
      calendar_id,
      max_results: 100000,
      single_events: true,
      show_deleted: true#,
      #sync_token: sync_token.token
    )
  else
    response = service.list_events(
      calendar_id,
      max_results: 100000,
      single_events: true,
      show_deleted: true
    )
    sync_token = SyncToken.new
    sync_token.google_calendar_id = calendar_id
  end
  
  # reset google sync token
  sync_token.token = response.next_sync_token
  sync_token.save
  
  puts "#{response.items.size} events returned"
  
  # return the response (event list etc.)
  response
end

# authorise to grab events from google calendar
def authorise_calendar_access
  scope = 'https://www.googleapis.com/auth/calendar'
  authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open('google-credentials.json'),
    scope: scope
  )
  authorizer.fetch_access_token!
  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = authorizer
  service
end