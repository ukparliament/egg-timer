module CALCULATION_BICAMERAL_PRAYING_DAYS_EITHER_HOUSE_SITTING
  
  # # A method for calculating scrutiny periods during which **either** House must be sitting or on a short adjournment, used for Commons and Lords negative Statutory Instruments and made affirmative SIs where this is set out by their enabling Act.
  # The calculation counts a day whenever either House has a praying day, requiring the laying date and the number of days to count.
  def bicameral_praying_days_calculation_either_house_sitting( date, target_day_count )
    
    
    # ## We start counting on the **first day when either House has a praying day**.
    # This may include the laying day of the instrument.
    # Unless the laying day is a praying day in either House, then ...
    unless date.is_commons_praying_day? or date.is_lords_praying_day?
      
      # ... if there is a future praying day in either House ...
      if date.first_praying_day_in_either_house
      
        # ... we set the date to that day.
        date = date.first_praying_day_in_either_house 
      
      # If we didn't find a **future praying day in either House** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future praying day in the House of Commons or the House of Lords. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
      
    # Otherwise, we've established the laying day is a praying day in at least one House, so we don't have to cycle through the calendar to find a subsequent one.
    end
    
    # We've found the first praying day in either House so we start counting from day 1.
    day_count = 1
    
    # ## Whilst the number of praying days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
    
      # ... and add 1 to the day count if this is a praying day in either House.
      day_count +=1 if date.is_either_house_praying_day?
      
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