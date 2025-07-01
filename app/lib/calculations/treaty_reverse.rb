module Calculations
  module TreatyReverse

    # # A method for calculating the start date for treaty periods A and B.
    # The calculation counts a day whenever both Houses have an actual sitting day - and requires the start date and the number of days to count.
    # For period A the start date is the day on which "a Minister of the Crown has laid before Parliament a copy of the treaty".
    # For period B the start date is the day on which "a Minister of the Crown has laid before Parliament a statement indicating that the Minister is of the opinion that the treaty should nevertheless be ratified and explaining why".
    # The calculation is defined by Constitutional Reform and Governance Act 2010 section 20 paragraphs [2](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2), [5](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-5) and [9](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-9).

    def treaty_calculation_reverse( date, target_day_count )
      
      # We set the scrutiny start date, being the start date of the calculation and the end date of the scrutiny period.
      @scrutiny_start_date = nil
      
      # We go forward one day.
      date = date.next
      
      # We set the day count to zero.
      day_count = 0
      
      # Whilst the number of days we’re counting is less than the target number of days to count ...
      while ( day_count < target_day_count ) do

        # ... continue to the **previous day**.
        date = date.prev_day
        
        # If the day is a joint actual sitting day ...
        if date.is_joint_actual_sitting_day?
          
          # ... we set the scrutiny start date to this date if the scrutiny start date is nil ...
          @scrutiny_start_date = date if @scrutiny_start_date.nil?

          # ... and add 1 to the day count.
          day_count +=1
        
        # Otherwise, if the calendar has no record of what type of day this is, we can't calculate the end date, ...
        elsif date.is_calendar_not_populated?

          # ... this error message is displayed to users ...
          @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."

          # ... and we stop looking through the calendar.
          break
        end
      end
      
      # We return the calculated date.
      date
    end
  end
end