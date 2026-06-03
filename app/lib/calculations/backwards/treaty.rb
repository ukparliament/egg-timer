module Calculations
  module Backwards
    module Treaty

      # # A method for calculating the start date for treaty periods A and B.
      # For period A the start date is the day on which "a Minister of the Crown has laid before Parliament a copy of the treaty".
      # For period B the start date is the day on which "a Minister of the Crown has laid before Parliament a statement indicating that the Minister is of the opinion that the treaty should nevertheless be ratified and explaining why".
      # The calculation is set out in the Constitutional Reform and Governance Act 2010 section 20 paragraphs [2](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2), [5](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-5) and [9](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-9).
      def treaty_calculation_backwards( target_end_date, target_day_count )
      
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
      
        # We set the day count to zero.
        day_count = 0
      
        # Whilst the number of days we’re counting is less than the target number of days to count ...
        while day_count < target_day_count

          # ... we move to the **previous day**.
          date = date.prev_day
        
          # If the day is a joint sitting day ...
          if date.is_joint_parliamentary_sitting_day?
          
            # ... if we've not set the scrutiny end date ...
            unless @scrutiny_end_date
            
              # ... we set the scrutiny end date to this date.
              @scrutiny_end_date = date
            end

            # We add 1 to the day count.
            day_count +=1
        
          # Otherwise, if the calendar has no record of what type of day this is, we can't calculate the end date, ...
          elsif date.is_calendar_not_populated?

            # ... this error message is displayed to users ...
            @error_message = "It's not currently possible to calculate an anticipated start date, as that date occurs during a period for which no sitting day information is available."

            # ... and we stop looking through the calendar.
            break
          end
        end
      
        # We return the anticipated start date of the scrutiny period for display.
        date
      end
    end
  end
end