module Syncing
	class SittingDayHandler
	  def self.process_event(event, house_id)
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

	   # ### A method to delete a sitting day with a given event id.
	  def self.delete_sitting_day( event_id )

	    # We find the sitting day with this event id.
	    sitting_day = SittingDay.all.where( "google_event_id = ?", event_id ).first

	    # If we've found one, we delete it.
	    sitting_day.destroy if sitting_day
	  end

	  def self.class_to_use_to_delete_all
	  	SittingDay
	  end
	end
end