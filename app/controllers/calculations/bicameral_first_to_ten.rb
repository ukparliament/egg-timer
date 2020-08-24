module CALCULATION_BICAMERAL_FIRST_TO_TEN
  
  # # A method for calculating scrutiny periods for Legislative Reform Orders (LROs), Localism Orders (LOs) and Public Body Orders (PBOs).
  # The calculation counts a day whenever both Houses have a praying sitting day, requiring the laying date and the number of days to count.
  def bicameral_first_to_ten_calculation( date, target_day_count )
  
    # ## We start counting on the **first day when both Houses have a parliamentary sitting following the laying of the instrument**.
    # If the date of laying day is a joint parliamentary sitting day, we do not count that day.
    # If we find a day meeting that criteria ...
    if date.next_day.first_joint_parliamentary_sitting_day
    
       # ... we set the date to start counting from as that day.
      date = date.next_day.first_joint_parliamentary_sitting_day

      # PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
      # The first joint sitting day counts as day 1, so we count from 1 rather than from 0.
    	commons_day_count = 1
      lords_day_count = 1
    
      # ## We look at subsequent days, ensuring that we've counted at least the set number of sitting days in each House. In the case of a PNSI, that's ten days.
      # While there are still days on which the Commons **or** Lords have sat for fewer than 10 days, we continue counting days ...
      while ( ( commons_day_count < target_day_count ) or ( lords_day_count < target_day_count ) ) do

        # ... continue to the **next day**.
        date = date.next_day

        # PNSIs use parliamentary sitting days, rather than naive calendar days.
        # If the Lords sat on the date we've found, we add another day to the Lords’ count.
        lords_day_count +=1 if date.is_lords_parliamentary_sitting_day?
        # If the Commons sat on the date we've found, we add another day to the Commons’ count.
        commons_day_count+=1 if date.is_commons_parliamentary_sitting_day?
  
        # If the calendar has no record of what type of day this is, we can't calculate the end date, ...
        if date.is_calendar_not_populated?
        
          # ... this error message is displayed to users ...
          @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
          
          # ... and we stop looking through the calendar.
          break
        end
      end

    # If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period ...
    else
    
      # ... and this error message is displayed.
      @error_message = "Unable to find a future joint sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
    end
  
    # Return the anticipated end date of the scrutiny period for display.
    date
  end
end