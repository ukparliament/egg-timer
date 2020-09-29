module CALCULATION_COMMONS_ONLY_SI
  
  # # A method for calculating the end date of a scrutiny period, based on days on which the House of Commons must be sitting or on a short adjournment. This method is used for Commons only negative and made affirmative Statutory Instruments.
  # The calculation counts in actual sitting days, requiring the start date and the number of days to count.
  # The calculation is defined by paragraphs 1 and 2 of [Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7), though a different calculation may be required if the instrument is laid under another Act - as per [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).
  
  def commons_only_si_calculation( date, target_day_count )
    
    # ## We start counting on the **first day the House of Commons has a scrutiny day**.
    # This will be the day on which the instrument was laid, if that day is a scrutiny day.
    # For made affirmative instruments, this is defined by the [Statutory Instruments Act 1946 Section 5 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1).
    # For draft instruments, this is defined by the [Statutory Instruments Act 1946 Section 6 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/6#section-6-1).
    # Unless the laying day is a House of Commons scrutiny day, then ...
    unless date.is_commons_scrutiny_day?
      
      # ... if there is a future House of Commons scrutiny day ...
      if date.first_commons_scrutiny_day 
      
        # ... we set the date to that day. In practice this will be the first sitting day following the laying.
        date = date.first_commons_scrutiny_day
        
      # If we didn't find a **future House of Commons scrutiny day** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future House of Commons sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
      
    # Otherwise, we've established the laying day is a House of Commons scrutiny day so we don't have to cycle through the calendar to find a subsequent one.
    end
    
    # We've found the first House of Commons scrutiny day so we start counting from day 1.
    day_count = 1
    
    # ## Whilst the number of days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
      
      # ... and add 1 to the day count if this is a House of Commons scrutiny day.
      day_count +=1 if date.is_commons_scrutiny_day?
      
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