module SYNC
  
  def sync_recess_dates( calendar_id, house_id )
    
    # Authorise to grab events from google calendar.
    service = authorise_calendar_access
  
    # Start with no page token because we don't know if the results are paginated.
    page_token = ''
  
    # Keep looping through pages to get events.
    loop do
  
      # Get any changed events from - this page of - the calendar.
      # Pass the calendar we're grabbing from and the page token (if any).
      response = get_changed_events_from_calendar( service, calendar_id, page_token )
  
      # Loop through all changed events.
      response.items.each do |event|
        
        # If the event is cancelled ...
        if event.status == 'cancelled'
          
          # ... we delete it.
          delete_recess_date( event.id )
        
        # If the event is confirmed ... 
        elsif event.status == 'confirmed'
        
          # ...if this is an edit (has it been updated since created) delete its previous incarnation.
          delete_recess_date( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes.
      
          # We set the start and end dates of the event.
          start_date = ( event.start.date || event.start.date_time ).to_date
          end_date = ( event.end.date || event.end.date_time ).to_date
          
          # We set the description of the event.
          description = event.summary
      
          # ...because all day appointments end at midnight the next day, subtract a day if there's no end datetime
          end_date = end_date - 1.day unless event.end.date_time
          
          # Create the recess and save it.
          recess_date = RecessDate.new
          recess_date.description = description
          recess_date.start_date = start_date
          recess_date.end_date = end_date
          recess_date.google_event_id = event.id
          recess_date.house_id = house_id
          recess_date.save
        end
        
        # We group adjournment days in a House into the recess.
        group_adjournment_days_in_house_into_recess( house_id, recess_date )
      end
    
      # If the reponse has returned a next page token...
      if response.next_page_token
      
        # ...set the page token to that returned so the next time through the loop it hits that page.
        page_token = response.next_page_token
      
      # If the response has not returned a next page token, we're at the last page...
      else
      
        # ...so we stop looping through pages.
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
  
  def sync_sitting_days( calendar_id, house_id )
  
    # Authorise to grab events from google calendar.
    service = authorise_calendar_access
  
    # Start with no page token because we don't know if the results are paginated.
    page_token = ''
  
    # Keep looping through pages to get events.
    loop do
  
      # Get any changed events from - this page of - the calendar.
      # Pass the calendar we're grabbing from and the page token (if any).
      response = get_changed_events_from_calendar( service, calendar_id, page_token )
  
      # Loop through all changed events.
      response.items.each do |event|
      
        # If the event is cancelled...
        if event.status == 'cancelled'
        
          # ...delete it.
          delete_sitting_days( event.id )
        
        # If the event is confirmed... 
        elsif event.status == 'confirmed'
        
          # ...if this is an edit (has it been updated since created) delete its previous incarnation.
          delete_sitting_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes.
      
          # ...set the start and end dates of the event.
          start_date = ( event.start.date || event.start.date_time ).to_date
          end_date = ( event.end.date || event.end.date_time ).to_date
      
          # ...because all day appointments end at midnight the next day, subtract a day if there's no end datetime
          end_date = end_date - 1.day unless event.end.date_time
      
          # ...find the session this event is in.
          # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session.
          session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first
        
          # ...if no session has been found...
          unless session
        
            # ...find the session that's not yet ended.
            session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
          end
        
          # ...if the sitting day can be associated with a session...
          if session
          
            # ...create and save it.
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
    
      # If the reponse has returned a next page token...
      if response.next_page_token
      
        # ...set the page token to that returned so the next time through the loop it hits that page.
        page_token = response.next_page_token
      
      # If the response has not returned a next page token, we're at the last page...
      else
      
        # ...so we stop looping through pages.
        break
      end
    end
  end

  def sync_virtual_sitting_days( calendar_id, house_id )
  
    # Authorise to grab events from google calendar.
    service = authorise_calendar_access

    # Start with no page token because we don't know if the results are paginated.
    page_token = ''
  
    # Keep looping through pages to get events.
    loop do
    
      # Get any changed events from - this page of - the calendar.
      # Pass the calendar we're grabbing from and the page token (if any).
      response = get_changed_events_from_calendar( service, calendar_id, page_token )
  
      # Loop through all changed events.
      response.items.each do |event|
      
        # If the event is cancelled...
        if event.status == 'cancelled'
        
          # ...delete it.
          delete_virtual_sitting_days( event.id )
        
        # If the event is confirmed...
        elsif event.status == 'confirmed'

          # ...if this is an edit (has it been updated since created) delete its previous incarnation.
          delete_virtual_sitting_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes.
      
          # ...set the start and end dates of the event.
          start_date = ( event.start.date || event.start.date_time ).to_date
          end_date = ( event.end.date || event.end.date_time ).to_date
      
          # ...because all day appointments end at midnight the next day, subtract a day if there's no end datetime.
          end_date = end_date - 1.day unless event.end.date_time
      
          # ...find the session this event is in.
          # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session.
          session = Session.all.where( "start_date <= ?", start_date ).where( "end_date >= ?", end_date ).first
        
          # ...if no session has been found...
          unless session
        
            # ...find the session that's not yet ended.
            session = Session.all.where( "start_date <= ?", start_date ).where( "end_date is null" ).first
          end
        
          # ...if the virtual sitting day can be associated with a session....
          if session
          
            # ...create and save it.
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
      
      # If the reponse has returned a next page token...
      if response.next_page_token
    
        # ...set the page token to that returned so the next time through the loop it hits that page.
        page_token = response.next_page_token
    
      # If the response has not returned a next page token, we're at the last page...
      else
    
        # ...so we stop looping through pages.
        break
      end
    end
  end

  def sync_adjournment_days( calendar_id, house_id )
  
    # Authorise to grab events from google calendar.
    service = authorise_calendar_access

    # Start with no page token because we don't know if the results are paginated.
    page_token = ''
  
    # Keep looping through pages to get events.
    loop do
    
      # Get any changed events from - this page of - the calendar.
      # Pass the calendar we're grabbing from and the page token (if any).
      response = get_changed_events_from_calendar( service, calendar_id, page_token )
  
      # Loop through all changed events.
      response.items.each do |event|
      
        # If the event is cancelled...
        if event.status == 'cancelled'
        
          # ...delete it.
          delete_adjournment_days( event.id )
        
        # If the event is confimed...
        elsif event.status == 'confirmed'
        
          # ...if this is an edit (has it been updated since created) delete it's previous incarnation.
          delete_adjournment_days( event.id ) if ( event.updated.to_i > event.created.to_i ) # convert to integer because blasted DateTimes.
      
          # ...set the start and end dates of the event.
          start_date = ( event.start.date || event.start.date_time ).to_date
          end_date = ( event.end.date || event.end.date_time ).to_date
      
          # ...because all day appointments end at midnight the next day, subtract a day if there's no end datetime.
          end_date = end_date - 1.day unless event.end.date_time
      
          # ...because adjournment days can be created as multiday events in the Google calendar but we split them out into separate days...
          # ...loop through all the dates covered...
          (start_date..end_date).each do |date|
      
            # ...find the session this event is in...
            # Where the start date of the event is on or after the start of the session and the end date of the event is before or on the end date of the session.
            session = Session.all.where( "start_date <= ?", date ).where( "end_date >= ?", date ).first
            unless session
          
              # ...find the session that's not yet ended.
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
          
            # ...if the adjournment day can be associated with a session...
            if session
            
              # ...create it and save it.
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
      
      # If the reponse has returned a next page token...
      if response.next_page_token
    
        # ...set the page token to that returned so the next time through the loop it hits that page.
        page_token = response.next_page_token
    
      # If the response has not returned a next page token, we're at the last page...
      else
    
        # ...so we stop looping through pages.
        break
      end
    end
  end

  # Delete an adjournment day with a given event id.
  def delete_adjournment_days( event_id )
  
    # Adjournment days can be created as multiday events which get split into individual days in the database calendar. So we need to...
    # ...find all the adjournment days with this event id.
    adjournment_days = AdjournmentDay.all.where( "google_event_id = ?", event_id )
  
    # Loop though all these adjournment days...
    adjournment_days.each do |adjournment_day|
    
      # ...and delete.
      adjournment_day.destroy
    end
  end

  # Delete a sitting day with a given event id.
  def delete_sitting_days( event_id )
  
    # Find the sitting day with this event id.
    sitting_day = SittingDay.all.where( "google_event_id = ?", event_id ).first
  
    # If you've found one, delete it.
    sitting_day.destroy if sitting_day
  end

  # Delete a virtual sitting day with a given event id.
  def delete_virtual_sitting_days( event_id )
  
    # Find the adjournment day with this event id.
    virtual_sitting_day = VirtualSittingDay.all.where( "google_event_id = ?", event_id ).first
  
    # If you've found one, delete it.
    virtual_sitting_day.destroy if virtual_sitting_day
  end
  
  # Delete a recess with a given event id.
  def delete_recess_date( event_id )
  
    # Find the recess date with this event id.
    recess_date = RecessDate.all.where( "google_event_id = ?", event_id ).first
    
    # If we find the recess date ...
    if recess_date
    
      # ... for each adjournment day grouped in this recess ...
      recess_date.adjournment_days.each do |adjournment_day|
      
        # ... we set the recess date ID to nil ...
        adjournment_date.recess_date = nil
      
        # ... and save the adjournment day.
        adjournment_day.save
      end
  
      # We delete the recess date.
      recess_date.destroy
    end
  end

  # Get a list of changed events from a - page of a - calendar (created, updated and deleted).
  def get_changed_events_from_calendar( service, calendar_id, page_token )
  
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

  # Authorise to grab events from Google calendar.
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
end