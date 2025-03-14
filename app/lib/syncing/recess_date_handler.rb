module Syncing
	class RecessDateHandler
	  def self.process_event(event, house_id)
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

	  ### A method to delete adjournment days with a given event id.
	  def self.delete_recess_date( event_id )

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

	  # ## A method to group adjournment days in a House into a recess.
	  def self.group_adjournment_days_in_house_into_recess( house_id, recess_date )

	    # For each day in the recess ...
	    ( recess_date.start_date .. recess_date.end_date ).each do |recess_day|

	      # ... we attempt to find an adjournment on that day, in that House.
	      adjournment_day = AdjournmentDay.find_by_sql([
	        "
	          SELECT ad.*
	          FROM adjournment_days ad
	          WHERE ad.house_id = :house_id
	          AND ad.date = :recess_day
	        ",
	        house_id: house_id,
	        recess_day: recess_day
	      ]).first

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

		def self.class_to_use_to_delete_all
	  	RecessDate
	  end

	end
end