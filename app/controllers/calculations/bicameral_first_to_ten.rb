module CALCULATION_BICAMERAL_FIRST_TO_TEN
  
  # # A method for calculating committee scrutiny periods for Proposed Negative Statutory Instruments (PNSIs).
  # Based on parliamentary sitting days.
  # Counted from first joint sitting day, then last House to 10.
  def bicameral_first_to_ten_calculation( date, target_day_count )
  
    # ## We start counting on the **first day when both Houses are sitting** after the instrument is laid and never on the day of laying.
    # If we find the **first joint sitting day** following the start date, the laying date in this case, ...
    if date.next_day.first_joint_parliamentary_sitting_day
    
      # ...we set the date to start counting as the first joint parliamentary sitting day.
      date = date.next_day.first_joint_parliamentary_sitting_day

    	# PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
      # The first joint sitting day counts as day 1, so we count from 1, not 0.
      commons_day_count = 1
      lords_day_count = 1
    
      # ## We look at subsequent days, ensuring that we've counted at least the set number of sitting days to count in each House. In the case of a PNSI, that's ten days.
      # This loop runs whilst the Commons have sat for less than 10 days ***or*** the Lords have sat for less than 10 days. If both Houses have sat for at least 10 days, it stops running.
      while ( ( commons_day_count < target_day_count ) or ( lords_day_count < target_day_count ) ) do

        # Go to the **next day**
        date = date.next_day

        # PNSIs use parliamentary sitting days and not naive calendar days.
        # If the Lords sat on the date we've found, we add another day to the count.
        lords_day_count +=1 if date.is_lords_parliamentary_sitting_day?
        # If the Commons sat on the date we've found, we add another day to the count.
        commons_day_count+=1 if date.is_commons_parliamentary_sitting_day?
  
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