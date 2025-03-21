module Syncing
	class AdjournmentDayHandler
	  def self.process_event(event, house_id)
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
	        recess_date = RecessDate.find_by_sql([
	          "
	            SELECT rd.*
	            FROM recess_dates rd
	            WHERE rd.house_id = :house_id
	            AND rd.start_date <= :date
	            AND rd.end_date >= :date
	          ",
	          house_id: house_id,
	          date: date
	        ]).first

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

	   # ### A method to delete adjournment days with a given event id.
	  def self.delete_adjournment_days( event_id )

	    # Adjournment days can be created as multiday events which get split into individual days in the database. So we find all the adjournment days with this event id.
	    adjournment_days = AdjournmentDay.all.where( "google_event_id = ?", event_id )

	    # For each adjournment day found ...
	    adjournment_days.each do |adjournment_day|

	      # ... we delete it.
	      adjournment_day.destroy
	    end
	  end

	  def self.delete_all(house_id, broken_sync_log)
	  	AdjournmentDay.where(house_id: house_id).delete_all
	  	broken_sync_log.update(successful: true)
	  end
	end
end