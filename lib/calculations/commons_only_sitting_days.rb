module CALCULATION_COMMONS_ONLY_SITTING_DAYS
  
  # # A method for calculating the end date for delegated legislation laid into the House of Commons only, taking account of sitting days.
  # The calculation counts a day whenever the House of Commons has an actual sitting day - and requires the start date and the number of days to count.
  # The calculation is set out in [section 5 (4A) of the Planning Act 2008](https://www.legislation.gov.uk/ukpga/2008/29/section/5#section-5-4A).
  
  def commons_only_sitting_days( date, target_day_count )
    
    # ## We start counting on the **first day when the House of Commons has an actual sitting**.
    
    # We continue to the **day immediately following** the start day.
    # If that day is or is followed by a House of Commons actual sitting day...
    if date.next_day.first_commons_actual_sitting_day
      
      # ... we set the date to the day of the first House of Commons actual sitting day **following** the start date.
      date = date.next_day.first_commons_actual_sitting_day
      
      # ... we have found the start of the scrutiny period.
      @scrutiny_start_date = date
      
      # ... we've found the first House of Commons actual sitting day so we start counting from day 1.
      day_count = 1
      
      # ... whilst the number of days we’re counting is less than the target number of days to count ...
      while ( day_count < target_day_count ) do
    
        # ... continue to the **next day**.
        date = date.next_day
    
        # ... and add 1 to the day count if this is a House of Commons actual sitting day.
        day_count +=1 if date.is_commons_actual_sitting_day?
    
         # ... if the calendar has no record of what type of day this is, we can't calculate the end date, ...
        if date.is_calendar_not_populated?
      
          # ... this error message is displayed to users ...
          @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
          
          # ... and we stop looking through the calendar.
          break
        end
      end
    
    # If **day immediately following** the laying day is not a House of Commons actual sitting day **and** is not followed by a House of Commons actual sitting day...
    else
  
      # .. this error message is displayed to users.
      @error_message = "Unable to find a future House of Commons sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
    end

    # Return the anticipated end date of the scrutiny period for display.
    date
  end
end