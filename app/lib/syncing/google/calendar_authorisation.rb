# # A module to sync data from a set of Google calendars to the egg timer database.
module Syncing
  module Google
    class CalendarAuthorisation

      # Authorise to grab events from Google calendar.
      def self.authorise_calendar_access
        scope = 'https://www.googleapis.com/auth/calendar'
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
          scope: scope
        )
        authorizer.fetch_access_token!
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = authorizer
        service
      end

      # Get a list of changed events from a - page of a - calendar (created, updated and deleted).
      def self.get_changed_events_from_calendar( service, calendar_id, page_token )

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
          end

          # ...set (or reset) the sync token
          sync_token.token = response.next_sync_token
          sync_token.save
        end

        # Tell us how many events this call returned.
        puts "#{response.items.size} events returned"

        # Return the response.
        response
      end
    end
  end
end