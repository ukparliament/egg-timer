module CALCULATION_BICAMERAL_PRAYING_DAYS_BOTH_HOUSES_SITTING

  # Used for some Commons and Lords made affirmative SIs
  # Counts when Commons AND Lords are sitting
  # Counts through short adjournments (not bums on seats)
  def bicameral_praying_days_calculation_both_houses_sitting( date, target_day_count )
  
    # Get ready to count praying days in both Houses
    # If this is not a praying day for the Commons and the Lords...
    unless date.is_joint_praying_day?
    
      # If there is a future praying day in the Commons or the Lords
      if date.first_joint_praying_day
      
        # Set the date to the first praying day in the Commons and the Lords
        date = date.first_joint_praying_day
      
      # If we didn't find any **future praying day* in our calendar, we can't calculate the scrutiny period - and we show an error message and stop running this code.
      else
  
        # This error message is displayed to users.
        @error_message = "Unable to find a future praying day in the House of Commons and the House of Lords. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        return
      end
    end
    
    # We've found the first joint praying day so start from 1
    day_count = 1

    # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
    while ( day_count < target_day_count ) do
    
      # Skip to the next calendar day
      date = date.next_day
    
      # If the date we've found was both a Commons and a Lords praying day, we add another day to the count.
      day_count +=1 if date.is_joint_praying_day?
    
      # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
      # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
      if date.is_calendar_not_populated?
        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        break
      end
    end
  
    # Return date for display on page
    date
  end
end