module CALCULATION_BICAMERAL_SI_EITHER_HOUSE_SITTING
  
  # # A method for calculating the end date of a scrutiny period, based on days on which **either** House must be sitting or on a short adjournment. This method is used for bicameral negative and made affirmative Statutory Instruments.
  # The calculation counts in actual sitting days, requiring the start date and the number of days to count.
  # The calculation is defined by the [Statutory Instruments Act 1946 Section 7 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1), though a different calculation may be required if the instrument is laid under another Act - as per [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).
  def bicameral_si_either_house_sitting_calculation( date, target_day_count )
    
    
    # ## We start counting on the **first day either House has a scrutiny day**.
    
    
    
    
    # For negative Statutory Instruments this will be the day on which the instrument was laid, if that day was a scrutiny day. This is defined by the [Statutory Instruments Act 1946 Section 6 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/6#section-6-1).
    # For made affirmatives this will be the day on which the instrument was made, if that day was a scrutiny day. This is defined by the [Statutory Instruments Act 1946 Section 5 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1).
    
    
    
    
    
    # If the laying day - or the making day for made affirmative instruments - is a scrutiny day in at least one House, we don't have to cycle through the calendar to find a subsequent one ...
    if date.is_either_house_scrutiny_day?
      
      # ... and the laying or making day is the start of the scrutiny period.
      @scrutiny_start_date = date
      
    # Otherwise, the laying or making day is not a scrutiny day in at least one House, then ...
    else
      
      # ... if there is a future scrutiny day in either House ...
      if date.first_scrutiny_day_in_either_house
      
        # ... we set the date to that day.
        date = date.first_scrutiny_day_in_either_house
        
        # ... we have found the start of the scrutiny period.
        @scrutiny_start_date = date
      
      # If we didn't find a **future scrutiny day in either House** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future scrutiny day in the House of Commons or the House of Lords. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
    end
    
    # We've found the first scrutiny day in either House so we start counting from day 1.
    day_count = 1
    
    # ## Whilst the number of scrutiny days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
    
      # ... and add 1 to the day count if this is a scrutiny day in either House.
      day_count +=1 if date.is_either_house_scrutiny_day?
      
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