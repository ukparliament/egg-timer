module CALCULATION_BICAMERAL_PARLIAMENTARY_DAYS

  # # A method for calculating scrutiny periods for Legislative Reform Orders (LROs), Localism Orders (LOs) and Public Body Orders (PBOs).
  # The calculation counts a day whenever both Houses have a praying sitting day, requiring the laying date and the number of days to count.
  def bicameral_parliamentary_days_calculation( date, target_day_count )
  
    # ## We start counting on the **first day when both Houses have a parliamentary sitting**.
    # This may include the laying day of the instrument.
    # Unless the laying day is a joint parliamentary sitting day ...
    unless date.is_joint_parliamentary_sitting_day?
    
      # ... we look for the next parliamentary sitting day. If there is a subsequent joint parliamentary sitting day ...
      if date.first_joint_parliamentary_sitting_day 
      
        # ... we set the date to the first joint parliamentary sitting day.
        date = date.first_joint_parliamentary_sitting_day 
      
       # If we didn't find a **future joint parliamentary sitting day** in our calendar, we can't calculate the scrutiny period ...
      else
  
         # ... this error message is displayed.
        @error_message = "Unable to find a future joint parliamentary sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
    end
  
    # We've found the first joint parliamentary sitting day so we start counting from day 1.
    day_count = 1
  
    # ## Whilst the number of parliamentary sitting days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
    
      # ... and add 1 to the day count if this is a joint parliamentary sitting day.
      day_count +=1 if date.is_joint_parliamentary_sitting_day?
    
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