require 'google/apis/calendar_v3'
require 'googleauth'

task :sync => [
  :sync_commons_sitting_days
]

task :sync_commons_sitting_days => :environment do
  scope = 'https://www.googleapis.com/auth/calendar'
  authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open('lib/tasks/credentials.json'),
    scope: scope
  )
  authorizer.fetch_access_token!
  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = authorizer
  
  #calendar_id = '20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com' #hoc
  calendar_id = 'o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com' #hol
  
  sync_token = SyncToken.find_by_google_calendar_id( calendar_id )
  if sync_token
    response = service.list_events(
      calendar_id,
      max_results: 10000,
      single_events: true,
      show_deleted: true,
      sync_token: sync_token.token
    )
  else
    response = service.list_events(
      calendar_id,
      max_results: 10000,
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
  response.items.each do |event|
    if event.status == 'cancelled'
      # sitting day and sitting date deletions
      puts "deleting event #{event.id}"
      sitting_dates = SittingDate.all.where( "google_event_id = ?", event.id )
      sitting_dates.each do |sitting_date|
        sitting_date.destroy
      end
      sitting_days = SittingDay.all.where( "google_event_id = ?", event.id )
      sitting_days.each do |sitting_day|
        sitting_day.destroy
      end
    else
      # sitting day and sitting dates creation
      puts "creating event #{event.id}"
      start_date = ( event.start.date || event.start.date_time ).to_date
      end_date = ( event.end.date || event.end.date_time ).to_date
      session = Session.all.where( "start_on <= ?", start_date ).where( "end_on >= ?", end_date ).first
      unless session
        session = Session.all.where( "start_on <= ?", start_date ).where( "end_on is null" ).first
        if session
          sitting_day = SittingDay.new
          sitting_day.google_event_id = event.id
          sitting_day.session = session
          sitting_day.house_id = 2 # HoL
          sitting_day.save
          (start_date..end_date).each do |date|
            sitting_date = SittingDate.new
            sitting_date.google_event_id = event.id
            sitting_date.sitting_day = sitting_day
            calendar_date = CalendarDate.find_by_date( date )
            if calendar_date
              sitting_date.calendar_date = calendar_date
              sitting_date.save
            end
          end
        end
      end
    end
  end
end



