# # A module to sync data from a set of Google calendars to the egg timer database.
module Syncing
  module GoogleCalendar

    # Authorise to grab events from Google calendar.
    def authorise_calendar_access
      scope = 'https://www.googleapis.com/auth/calendar'
      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        scope: scope
      )
      authorizer.fetch_access_token!
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = authorizer
      service
    end

    def generic_sync(calendar_id, house_id, handler)
      # Check for failure first
      if DetailedSyncLog.where(google_calendar_id: calendar_id, successful: false).any?
        Rails.logger.info "We have had an error, so do not sync #{lookup_calendar_name(calendar_id)}"
        broken_sync_log = DetailedSyncLog.where(google_calendar_id: calendar_id, successful: false).order(created_at: :desc).first

        Rails.logger.info "We have the handler #{handler.name} so delete all"

        handler.delete_all(house_id, broken_sync_log)

        existing_sync_token = SyncToken.find_by(google_calendar_id: calendar_id)
        existing_sync_token.delete if existing_sync_token.present?
      else
        Rails.logger.info "All ok, do a sync for calendar_id: #{calendar_id}  and house: #{house_id}"
      end

      generic_sync_wrapper(calendar_id, house_id, handler)
    end

    def generic_sync_wrapper(calendar_id, house_id, handler)
      # We authorise to grab events from the google calendar.
      service = authorise_calendar_access

      # We start with no page token because we don't know if the results are paginated.
      page_token = ''

      # We keep looping through pages to get events.
      loop do

        # We get any changed events from - this page of - the calendar.
        # We pass the calendar we're grabbing from and the page token (if any).
        response = get_changed_events_from_calendar(service, calendar_id, house_id, page_token)

        unless response
          Rails.logger.info "No response from get changed events for #{lookup_calendar_name(calendar_id)}"

          return
        end

        response.items.each do |event|
          # Here we process response
          handler.process_event(event, house_id)
        end

        # If the reponse has returned a next page token ...
        if response.next_page_token

          # ... we set the page token to that returned, so the next time through the loop it hits that page.
          page_token = response.next_page_token

        # Otherwise, if the response has not returned a next page token, we're at the last page ...
        else

          # ...so we stop looping through pages.
          break
        end
      end
    end

    # ### A method to sync sitting days.
    def sync_sitting_days( calendar_id, house_id)
      generic_sync(calendar_id, house_id, SittingDayHandler)
    end

    # ### A method to sync virtual sitting days.
    def sync_virtual_sitting_days( calendar_id, house_id )
      generic_sync(calendar_id, house_id, VirtualSittingDayHandler)
    end

    # ### A method to sync adjournment days.
    def sync_adjournment_days( calendar_id, house_id )
      generic_sync(calendar_id, house_id, AdjournmentDayHandler)
    end

    # ### A method to sync recess dates.
    def sync_recess_dates( calendar_id, house_id )
      generic_sync(calendar_id, house_id, RecessDateHandler)
    end

    # Get a list of changed events from a - page of a - calendar (created, updated and deleted).
    def get_changed_events_from_calendar( service, calendar_id, house_id, page_token )

      # Check if there's already a sync token for this calendar in the database.
      sync_token = SyncToken.find_by_google_calendar_id( calendar_id )

      # If there is a sync token for this calendar...
      if sync_token

        # ...get any changes since that last sync token.
        response = service.list_events(
          calendar_id,
          max_results: 2500, # 2500 is the maximum Google will return per page.
          single_events: true,
          show_deleted: true,
          page_token: page_token,
          sync_token: sync_token.token
        )

      # If there is no sync token for this calendar...
      else

        # ...get any changes since the start of that calendar's time.
        response = service.list_events(
          calendar_id,
          max_results: 2500, # 2500 is the maximum Google will return per page.
          single_events: true,
          show_deleted: true,
          page_token: page_token
        )
      end

      # If a sync token has been returned by the Google API...
      if response.next_sync_token

        # ..but the database doesn't already have a sync token for this calendar...
        unless sync_token

          # ...create a new sync token in the database for this calendar
          sync_token = SyncToken.new
          sync_token.google_calendar_id = calendar_id
          sync_token.house_id = house_id
          sync_token.google_calendar_name = lookup_calendar_name(calendar_id)
        end

        # ...set (or reset) the sync token
        sync_token.token = response.next_sync_token
        sync_token.save
      end

    rescue Google::Apis::ClientError => exception
      # Something went wrong with this sync
      message = "An error occured for this calendar #{calendar_id} - #{exception.message}"
      successful = false

    else
      # All went ok
      message = "Sync complete - #{response.items.size} events returned"
      successful = true
      response
    ensure
      events_count = response ? response.items.size : 0

      # Always run this bit
      log = DetailedSyncLog.create(
        google_calendar_id: calendar_id,
        message: message,
        successful: successful,
        calendar_name: lookup_calendar_name(calendar_id),
        events_count: events_count
      )

      unless successful
        SyncFailureMailer.sync_fail_mail(log.id).deliver_now
        log.update(emailed: true)
      end
    end

    # These are set in config/initializers/google_calendar_ids.rb
    # and are pulled in from environment variables
    def lookup_calendar_name(calendar_id)
      case calendar_id
      when COMMONS_SITTING_DAYS_CALENDAR
        "Commons sitting day calendar"
      when LORDS_SITTING_DAYS_CALENDAR
        "Lords sitting day calendar"
      when LORDS_VIRTUAL_SITTING_DAYS_CALENDAR
        "Lords virtual sitting days calendar"
      when COMMONS_ADJOURNMENT_DAYS_CALENDAR
        "Commons adjournment day calendar"
      when LORDS_ADJOURNMENT_DAYS_CALENDAR
        "Lords adjournment day calendar"
      when COMMONS_RECESS_DAYS_CALENDAR
        "Commons recess days calendar"
      when LORDS_RECESS_DAYS_CALENDAR
        "Lords recess days calendar"
      end
    end
  end
end