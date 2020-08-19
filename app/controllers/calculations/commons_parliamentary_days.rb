module CALCULATION_COMMONS_PARLIAMENTARY_DAYS

  # A method for calculating based on "bums on seats" in Commons only
  # Used for treaty period B
  def commons_parliamentary_days_calculation( date, target_day_count )
  
    # Get ready to count parliamentary sitting days in the House of Commons
    # If this is not a parliamentary sitting day for the Commons...
    unless date.is_commons_parliamentary_sitting_day?
    
      # If there is a future parliamentary sitting day in the Commons...
      if date.first_commons_parliamentary_sitting_day
      
        # Set the date to the first parliamentary sitting day in the Commons
        date = date.first_commons_parliamentary_sitting_day 
      
      # If we didn't find any **future House of Commons parliamentary sitting day* in our calendar, we can't calculate the scrutiny period - and we show an error message and stop running this code.
      else
  
        # This error message is displayed to users.
        @error_message = "Unable to find a future parliamentary sitting day in the House of Commons. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        return
      end
    end
    
    # We've found the first parliamentary sitting day in the House of Commons so start from 1
    day_count = 1
  
    # ... we look at subsequent days, ensuring that we've counted at least the set number of commons parliamentary sitting days.
    while ( day_count < target_day_count ) do
    
      # Go to the next day
      date = date.next_day
    
      # Add 1 to the day count if this is a Commons parliamentary sitting day
      day_count +=1 if date.is_commons_parliamentary_sitting_day?
    
      # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
      # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
      if date.is_calendar_not_populated?
      
        # This error message is displayed to users.
        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        break
      end
    end
  
    # Return date for display on page
    date
  end
end