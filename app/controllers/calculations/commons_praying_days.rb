module CALCULATION_COMMONS_PRAYING_DAYS
  
  # # A method for calculating the end date of scrutiny periods during which the House of Commons must be sitting or on a short adjournment, used for House of Commons only draft and made affirmative Statutory Instruments.
  # The calculation counts a day whenever the House of Commons has a praying day, requiring the laying date and the number of days to count.
  def commons_praying_days_calculation( date, target_day_count )
    
    # ## We start counting on the **first day when the House of Commons has a praying day**.
    # This may include the laying day of the instrument.
    # Unless the laying day is a House of Commons praying day, then ...
    unless date.is_commons_praying_day?
      
      # ... if there is a future House of Commons praying day ...
      if date.first_commons_praying_day 
      
        # ... we set the date to that day.
        date = date.first_commons_praying_day
        
      # If we didn't find a **future House of Commons praying day** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future House of Commons praying day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
    # Otherwise, we've established the laying day is a House of Commons praying day so we don't have to cycle through the calendar to find a subsequent one.
    end
    
    # We've found the first House of Commons praying day so we start counting from day 1.
    day_count = 1
    
    # ## Whilst the number of days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
      
      # ... and add 1 to the day count if this is a House of Commons praying day.
      day_count +=1 if date.is_commons_praying_day?
      
      # ... if the calendar has no record of what type of day this is, we can't calculate the end date, ...
      if date.is_calendar_not_populated?
        
        # ... this error message is displayed to users ...
        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking through the calendar.
        break
      end
    end
  
    # Return the anticipated end date of the scrutiny period for display.
    date
  end
end