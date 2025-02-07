# # A module to sync data from a set of Google calendars to the egg timer database.
module Syncing
  module Google
    module CalendarPullEvents
      include CalendarAuthorisation
      include CalendarDeleteEvents

      # ## Sync methods for assorted types of events.

      # ### A method to sync sitting days.
      def sync_sitting_days( calendar_id, house_id )
        # Default outcome
        successful = false

        # We authorise to grab events from the google calendar.
        service = authorise_calendar_access

        # We start with no page token because we don't know if the results are paginated.
        page_token = ''

        # We keep looping through pages to get events.
        loop do

          # We get any changed events from - this page of - the calendar.
          # We pass the calendar we're grabbing from and the page token (if any).
          response = get_changed_events_from_calendar( service, calendar_id, page_token )

          # For each event ...
          response.items.each do |event|

            # ... we attempt to find the event in the database.
            sitting_day = SittingDay.find_by_google_event_id( event.id )

            # If we find the event in the database ...
            if sitting_day

              # ... we delete it.
              delete_sitting_day( event.id )
            end

            # If the event is confirmed ...
            if event.status == 'confirmed'

              # ... we set the start and end dates of the event.
              start_date = ( event.start.date || event.start.date_time ).to_date
              end_date = ( event.end.date || event.end.date_time ).to_date

              # Because all day appointments end at midnight the next day, we subtract a day if there's no end datetime.
              end_date = end_date - 1.day unless event.end.date_time

              # We find the session this event is in.
              # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session.
              session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first

              # If no session has been found ...
              unless session

                # ... we find the session that's not yet ended.
                session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
              end

              # If the sitting day can be associated with a session ...
              if session

                # ... we create and save it.
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

        message = "Sync complete"
        successful = true
      rescue Google::Apis::ClientError => exception
        # Something went wrong with this sync
        message = "An error occured for this calendar #{calendar_id}"
        successful = false
      else
        # All went ok
      ensure
        # Always run this bit
        SyncLog.create(
          google_calendar_id: calendar_id,
          message: message,
          successful: successful,
          calendar_name: "Malcolm"




          )
      end

      # ### A method to sync virtual sitting days.
      def sync_virtual_sitting_days( calendar_id, house_id )

        # We authorise to grab events from the google calendar.
        service = authorise_calendar_access

        # We start with no page token because we don't know if the results are paginated.
        page_token = ''

        # We keep looping through pages to get events.
        loop do

          # We get any changed events from - this page of - the calendar.
          # We pass the calendar we're grabbing from and the page token (if any).
          response = get_changed_events_from_calendar( service, calendar_id, page_token )

          # For each event ...
          response.items.each do |event|

            # ... we attempt to find the event in the database.
            virtual_sitting_day = VirtualSittingDay.find_by_google_event_id( event.id )

            # If we find the event in the database ...
            if virtual_sitting_day

              # ... we delete it.
              delete_virtual_sitting_day( event.id )
            end

            # If the event is confirmed ...
            if event.status == 'confirmed'

              # ... we set the start and end dates of the event.
              start_date = ( event.start.date || event.start.date_time ).to_date
              end_date = ( event.end.date || event.end.date_time ).to_date

              # Because all day appointments end at midnight the next day, we subtract a day if there's no end datetime.
              end_date = end_date - 1.day unless event.end.date_time

              # We find the session this event is in.
              # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session.
              session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first

              # If no session has been found ...
              unless session

                # ... we find the session that's not yet ended.
                session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
              end

              # ... if the virtual sitting day can be associated with a session ...
              if session

                # ... we create and save it.
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

          # If the reponse has returned a next page token ...
          if response.next_page_token

            # ... we set the page token to that returned, so the next time through the loop it hits that page.
            page_token = response.next_page_token

          # If the response has not returned a next page token, we're at the last page ...
          else

            # ... so we stop looping through pages.
            break
          end
        end
      end

      # ### A method to sync adjournment days.
      def sync_adjournment_days( calendar_id, house_id )

        # We authorise to grab events from the google calendar.
        service = authorise_calendar_access

        # We start with no page token because we don't know if the results are paginated.
        page_token = ''

        # We keep looping through pages to get events.
        loop do

          # We get any changed events from - this page of - the calendar.
          # We pass the calendar we're grabbing from and the page token (if any).
          response = get_changed_events_from_calendar( service, calendar_id, page_token )

          # For each event ...
          response.items.each do |event|

            # ... we attempt to find the event in the database.
            adjournment_day = AdjournmentDay.find_by_google_event_id( event.id )

            # If we find the event in the database ...
            if adjournment_day

              # ... we delete it.
              delete_adjournment_days( event.id )
            end

            # If the event is confirmed ...
            if event.status == 'confirmed'

              # ... we set the start and end dates of the event.
              start_date = ( event.start.date || event.start.date_time ).to_date
              end_date = ( event.end.date || event.end.date_time ).to_date

              # Because all day appointments end at midnight the next day, we subtract a day if there's no end datetime.
              end_date = end_date - 1.day unless event.end.date_time

              # Because adjournment days can be created as multiday events in the Google calendar, but we split them out into separate days in the database ...
              # ... we loop through all the dates covered.
              (start_date..end_date).each do |date|

                # We find the session this date is in.
                # Where the date is on or after the start of the session and before or on the end date of the session.
                session = Session.all.where( "start_date <= ?", date ).where( "end_date >= ?", date ).first

                # If no session has been found ...
                unless session

                  # ... we find the session that's not yet ended.
                  session = Session.all.where( "start_date <= ?", date ).where( "end_date is null" ).first
                end

                # We attempt to find any recess date in this House that the adjournment date is in.
                # In case the recess has been created before the adjournment.
                recess_date = RecessDate.find_by_sql(
                  "
                    SELECT rd.*
                    FROM recess_dates rd
                    WHERE rd.house_id = #{house_id}
                    AND rd.start_date <= '#{date}'
                    AND rd.end_date >= '#{date}'
                  "
                ).first

                # If the adjournment day can be associated with a session ...
                if session

                  # ... we create it and save it.
                  adjournment_day = AdjournmentDay.new
                  adjournment_day.date = date
                  adjournment_day.google_event_id = event.id
                  adjournment_day.session = session
                  adjournment_day.house_id = house_id
                  adjournment_day.recess_date = recess_date if recess_date
                  adjournment_day.save
                end
              end
            end
          end

          # If the reponse has returned a next page token ...
          if response.next_page_token

            # ... we set the page token to that returned, so the next time through the loop it hits that page.
            page_token = response.next_page_token

          # If the response has not returned a next page token, we're at the last page ...
          else

            # ... so we stop looping through pages.
            break
          end
        end
      end

      # ### A method to sync recess dates.
      def sync_recess_dates( calendar_id, house_id )

        # We authorise to grab events from the google calendar.
        service = authorise_calendar_access

        # We start with no page token because we don't know if the results are paginated.
        page_token = ''

        # We keep looping through pages to get events.
        loop do

          # We get any changed events from - this page of - the calendar.
          # We pass the calendar we're grabbing from and the page token (if any).
          response = get_changed_events_from_calendar( service, calendar_id, page_token )

          # For each event ...
          response.items.each do |event|

            # ... we attempt to find the event in the database.
            recess_date = RecessDate.find_by_google_event_id( event.id )

            # If we find the event in the database ...
            if recess_date

              # ... we delete it.
              delete_recess_date( event.id )
            end

            # If the event is confirmed ...
            if event.status == 'confirmed'

              # ... we set the start and end dates of the event.
              start_date = ( event.start.date || event.start.date_time ).to_date
              end_date = ( event.end.date || event.end.date_time ).to_date

              # We set the description of the event.
              description = event.summary

              # Because all day appointments end at midnight the next day, we subtract a day if there's no end datetime.
              end_date = end_date - 1.day unless event.end.date_time

              # We create the recess and save it.
              recess_date = RecessDate.new
              recess_date.description = description
              recess_date.start_date = start_date
              recess_date.end_date = end_date
              recess_date.google_event_id = event.id
              recess_date.house_id = house_id
              recess_date.save!

              # We group adjournment days in a House into the recess.
              group_adjournment_days_in_house_into_recess( house_id, recess_date )
            end
          end

          # If the reponse has returned a next page token ...
          if response.next_page_token

            # ... we set the page token to that returned, so the next time through the loop it hits that page.
            page_token = response.next_page_token

          # Otherwise, if the response has not returned a next page token, we're at the last page ...
          else

            # ... so we stop looping through pages.
            break
          end
        end
      end

      # ## A method to group adjournment days in a House into a recess.
      def group_adjournment_days_in_house_into_recess( house_id, recess_date )

        # For each day in the recess ...
        ( recess_date.start_date .. recess_date.end_date ).each do |recess_day|

          # ... we attempt to find an adjournment on that day, in that House.
          adjournment_day = AdjournmentDay.find_by_sql(
            "
              SELECT ad.*
              FROM adjournment_days ad
              WHERE ad.house_id = #{house_id}
              AND ad.date = '#{recess_day}'
            "
          ).first

          # If we find an adjournment on that day, in that House ...
          if adjournment_day

            # ... we associate the adjournment day with the recess ...
            adjournment_day.recess_date = recess_date

            # ... and save the adjournment day.
            adjournment_day.save

          # Otherwise, if we don't find an adjournment on that day in that House ...
          else

            # ... we flag an error.
            puts "Error #{recess_day} is not an adjournment day in House #{house_id}"
          end
        end
      end
    end
  end
end