module CALCULATION_TREATY
  
  # # A method for calculating the end date for treaty periods A and B.
  # The calculation counts a day whenever both Houses have an actual sitting day - and requires the start date and the number of days to count.
  # For period A the start date is the day on which "a Minister of the Crown has laid before Parliament a copy of the treaty".
  # For period B the start date is the day on which "a Minister of the Crown has laid before Parliament a statement indicating that the Minister is of the opinion that the treaty should nevertheless be ratified and explaining why".
  # The calculation is defined by Constitutional Reform and Governance Act 2010 section 20 paragraphs [2](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2), [5](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-5) and [9](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-9).
  
  def treaty_calculation( date, target_day_count )
    
    # ## We start counting on the **first day when both Houses have an actual sitting**.
    # For period A this **does not** include the laying day of the treaty.
    # For period B this **does not** include the day on which a Minister makes a statement that the treaty should nevertheless be ratified.
    # The first following joint actual sitting day is the start of the scrutiny period.
    
    # We continue to the **day immediately following** the start day.
    # If that day is or is followed by a joint actual sitting day...
    if date.next_day.first_joint_actual_sitting_day
      
      # ... we set the date to the day of the first joint actual sitting day **following** the start date.
      date = date.next_day.first_joint_actual_sitting_day
      





      # comment this
      @scrutiny_start_date = date
      
      # ... we've found the first joint actual sitting day so we start counting from day 1.
      day_count = 1
      
      # ... whilst the number of days we’re counting is less than the target number of days to count ...
      while ( day_count < target_day_count ) do
    
        # ... continue to the **next day**.
        date = date.next_day
    
        # ... and add 1 to the day count if this is an joint actual sitting day.
        day_count +=1 if date.is_joint_actual_sitting_day?
    
         # ... if the calendar has no record of what type of day this is, we can't calculate the end date, ...
        if date.is_calendar_not_populated?
      
          # ... this error message is displayed to users ...
          @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
          
          # ... and we stop looking through the calendar.
          break
        end
      end
    
    # If **day immediately following** the laying day is not a joint actual sitting day **and** is not followed by a joint actual sitting day...
    else
  
      # .. this error message is displayed to users.
      @error_message = "Unable to find a future joint sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
    end

    # Return the anticipated end date of the scrutiny period for display.
    date
  end
end