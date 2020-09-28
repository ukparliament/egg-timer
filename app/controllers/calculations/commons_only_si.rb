module CALCULATION_COMMONS_ONLY_SI
  
  # # A method for calculating the end date of scutiny periods based on days on which the House of Commons must be sitting or on a short adjournment, used for Commons only negative and made affirmative Statutory Instruments.
  # The calculation counts in actual sitting days and requires the start date and the number of days to count.
  # The calculation is defined by the [Statutory Instruments Act 1946 Section 7 paragraph 1 ](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2) as modified by [paragraph 2](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-2).
  
  
  
  
  def commons_only_si_calculation( date, target_day_count )
    
    # ## We start counting on the **first day when the House of Commons has a praying day**.
    # This may include the laying day of the instrument.
    # For made affirmative instruments this is defined by the [Statutory Instruments Act 1946 Section 5 paragraph
    # For draft instruments this is defined by the [Statutory Instruments Act 1946 Section 6 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/6#section-6-1) 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1)
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