# # A module to sync data from a set of Google calendars to the egg timer database.
module Syncing
  module Google
    module CalendarDeleteEvents
      # ## Delete methods for assorted types of event.

      # ### A method to delete a sitting day with a given event id.
      def delete_sitting_day( event_id )

        # We find the sitting day with this event id.
        sitting_day = SittingDay.all.where( "google_event_id = ?", event_id ).first

        # If we've found one, we delete it.
        sitting_day.destroy if sitting_day
      end

      # ### A method to delete a virtual sitting day with a given event id.
      def delete_virtual_sitting_day( event_id )

        # We find the virtual sitting day with this event id.
        virtual_sitting_day = VirtualSittingDay.all.where( "google_event_id = ?", event_id ).first

        # If we've found one, we delete it.
        virtual_sitting_day.destroy if virtual_sitting_day
      end

      # ### A method to delete adjournment days with a given event id.
      def delete_adjournment_days( event_id )

        # Adjournment days can be created as multiday events which get split into individual days in the database. So we find all the adjournment days with this event id.
        adjournment_days = AdjournmentDay.all.where( "google_event_id = ?", event_id )

        # For each adjournment day found ...
        adjournment_days.each do |adjournment_day|

          # ... we delete it.
          adjournment_day.destroy
        end
      end

      # ### A method to delete a recess with a given event id.
      def delete_recess_date( event_id )

        # We find the recess date with this event id.
        recess_date = RecessDate.all.where( "google_event_id = ?", event_id ).first

        # If we find the recess date ...
        if recess_date

          # ... for each adjournment day grouped in this recess ...
          recess_date.adjournment_days.each do |adjournment_day|

            # ... we set the recess date ID to nil ...
            adjournment_day.recess_date = nil

            # ... and save the adjournment day.
            adjournment_day.save
          end

          # We delete the recess date.
          recess_date.destroy
        end
      end
    end
  end
end