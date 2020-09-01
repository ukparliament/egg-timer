module CALCULATION_COMMONS_PARLIAMENTARY_DAYS
  
  # # A method for calculating scrutiny periods during which the House of Commons must be sitting, used for treaty period B.
  # The calculation counts a day whenever the House of Commons has a parliamentary sitting day, requiring the date of the government statement that the treaty should nonetheless be ratified and the number of days to count.
  # 1st September 2020 - we have assumed that the trigger for this calculation is the date of the government statement **and** that this day counts toward the total if it is a parliamentary sitting day in the House of Commons.
  def commons_parliamentary_days_calculation( date, target_day_count )
    
    
    # ## We start counting on the **first day when the House of Commons has a parliamentary sitting day**.
    # This may include the day of the government statement.
    # Unless that day is a House of Commons parliamentary sitting day, then ...
    unless date.is_commons_parliamentary_sitting_day?
    
      # ... if there is a future House of Commons parliamentary sitting day ...
      if date.first_commons_parliamentary_sitting_day
      
        # ... we set the date to that day.
        date = date.first_commons_parliamentary_sitting_day 
      
      # If we didn't find a **future House of Commons parliamentary sitting day** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future parliamentary sitting day in the House of Commons. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
      
    # Otherwise, we've established that the day of the government statement is a House of Commons parliamentary sitting day, so we don't have to cycle through the calendar to find a subsequent one.
    end
    
    # We've found the first House of Commons parliamentary sitting day so we start counting from day 1.
    day_count = 1
    
    # ## Whilst the number of days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
    
      # ... and add 1 to the day count if this is a House of Commons parliamentary sitting day.
      day_count +=1 if date.is_commons_parliamentary_sitting_day?
      
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