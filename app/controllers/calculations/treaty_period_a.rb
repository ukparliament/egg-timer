module CALCULATION_TREATY_PERIOD_A

  # Used for treaty period A
  # A method for calculating based on "bums on seats" in both Houses
  # Where both Houses must be sitting to count (Commons AND Lords)
  # Starts on first joint sitting day following laying
  def treaty_period_a_calculation( date, target_day_count )
  
    # We start counting on the **first day when both Houses are sitting** after the instrument is laid and never on the day of laying.
    # If we find the **first joint sitting day** following the start date, the laying date in this case, ...
    if date.next_day.first_joint_parliamentary_sitting_day
  
      # We set the date to start counting as the first joint parliamentary sitting day.
      date = date.next_day.first_joint_parliamentary_sitting_day

      # We've found the first joint parliamentary sitting day so start from 1
      day_count = 1
  
      # ... we look at subsequent days, ensuring that we've counted at least the set number of joint parliamentary sitting days.
      while ( day_count < target_day_count ) do
    
        # Go to the next day
        date = date.next_day
    
        # Add 1 to the day count if this is a joint parliamentary sitting day
        day_count +=1 if date.is_joint_parliamentary_sitting_day?
    
        # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
        # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
        if date.is_calendar_not_populated?
      
          # This error message is displayed to users.
          @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
          break
        end
      end

    # If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period - and we show an error message.
    else
  
      # This error message is displayed to users.
      @error_message = "Unable to find a future joint sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
    end

    # Return date for display on page
    date
  end
end