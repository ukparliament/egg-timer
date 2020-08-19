module CALCULATION_COMMONS_PRAYING_DAYS
  
  # Used for Commons only negative and affirmative SIs
  # Counts through short adjournments
  def commons_praying_days_calculation( date, target_day_count )
  
    # Get ready to count praying days in the House of Commons
    # If this is not a praying day for the Commons...
    unless date.is_commons_praying_day?
    
      # If there is a future Commons praying day
      if date.first_commons_praying_day 
      
        # Set the date to the first Commons praying day
        date = date.first_commons_praying_day 
      
      # If we didn't find any **future Commons praying day* in our calendar, we can't calculate the scrutiny period - and we show an error message and stop running this code.
      else
  
        # This error message is displayed to users.
        @error_message = "Unable to find a future House of Commons praying day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        return
      end
    end
    
    # We've found the first praying day so start from 1
    day_count = 1

    # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
    while ( day_count < target_day_count ) do
    
      # Skip to the next calendar day
      date = date.next_day
    
      # If the date we've found was a Commons praying day, we add another day to the count.
      day_count +=1 if date.is_commons_praying_day?
    
      # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
      # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
      if date.is_calendar_not_populated?
      
        # This error message is displayed to users unless an error message was set earlier
        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
         break
      end
    end
  
    # Return date for display on page
    date
  end
end