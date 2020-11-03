module CALCULATION_BICAMERAL_BOTH_HOUSES_SITTING
  
  # # A method for calculating the end date of scrutiny periods during which **both** Houses must be sitting or on a short adjournment, used for made affirmative Statutory Instruments where this is set out by their enabling Act.
  # The Statutory Instrument Act 1946 [sets out](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1) that - in calculating the scrutiny period for an SI under that Act - “no account shall be taken of any time during which Parliament is dissolved or prorogued or during which *both* Houses are adjourned for more than four days.” This applies to the majority of made affirmative instruments.
  # Made affirmatives laid under different Acts follow other rules, for example: the National Insurance Contributions Act 2014 [sets out](https://www.legislation.gov.uk/ukpga/2014/7/section/5/enacted#section-5-9), “no account is to be taken of any time ... during which either House is adjourned for more than four days.
  # This calculation deals with the case where days are not counted if *either* House is adjourned for more than four days.
  
  
  def bicameral_si_calculation_both_houses_sitting( date, target_day_count )
    
    # ## We start counting on the **first day both Houses have a scrutiny day**.
    # This will be the day on which the instrument was laid, if that day is a scrutiny day.
    # For made affirmative instruments, lacking explicit instructions in enabling Acts, we decide to take the definition from the [Statutory Instruments Act 1946 Section 5 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1).
    # Unless the laying day is a scrutiny day in both Houses, then ...
    unless date.is_joint_scrutiny_day?
      
      # ... if there is a future joint scrutiny day ...
      if date.first_joint_scrutiny_day
      
        # ... we set the date to that day.
        date = date.first_joint_scrutiny_day
      
      # If we didn't find a **future joint scrutint day** in our calendar, we can't calculate the scrutiny period, ...
      else
  
        # ... this error message is displayed ...
        @error_message = "Unable to find a future joint scrutiny day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        
        # ... and we stop looking for a scrutiny period end date.
        return
      end
      
    # Otherwise, we've established the laying day is a joint scrutiny day so we don't have to cycle through the calendar to find a subsequent one.
    end
    
    # We've found the first joint scrutiny day so we start counting from day 1.
    day_count = 1

    # ## Whilst the number of joint scrutiny days we’re counting is less than the target number of days to count ...
    while ( day_count < target_day_count ) do
    
      # ... continue to the **next day**.
      date = date.next_day
    
      # ... and add 1 to the day count if this is a joint scrutiny day.
      day_count +=1 if date.is_joint_scrutiny_day?
    
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