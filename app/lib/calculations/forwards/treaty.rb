module Calculations
  module Forwards
    module Treaty

      # # A method for calculating the end date for treaty periods A and B.
      # For period A the start date is the day on which "a Minister of the Crown has laid before Parliament a copy of the treaty".
      # For period B the start date is the day on which "a Minister of the Crown has laid before Parliament a statement indicating that the Minister is of the opinion that the treaty should nevertheless be ratified and explaining why".
      # The calculation is set out in the Constitutional Reform and Governance Act 2010 section 20 paragraphs [2](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2), [5](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-5) and [9](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-9).
      def treaty_calculation_forwards( date, target_day_count )
      
        # We set the day count to zero.
        day_count = 0
    
        # While the number of days we’ve counted is less than the target number of days to count ...
        while ( day_count < target_day_count )
      
          # ... we continue to the **next day**.
          date = date.next_day
        
          # If the day is a joint sitting day ...
          if date.is_joint_parliamentary_sitting_day?
        
            # ... if we've not set the scrutiny start date ...
            unless @scrutiny_start_date
        
              # ... we set the scrutiny start date to this date.
              @scrutiny_start_date = date
            end
        
            # We add one to the day count.
            day_count += 1
          end
        
          # If the calendar has no record of what type of day this is, we can't calculate the end date, ...
          if date.is_calendar_not_populated?

             # ... this error message is displayed to users ...
             @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."

             # ... and we stop looking through the calendar.
             break
          end
        end
      
        # We return the anticipated end date of the scrutiny period for display.
        date
      end
    end
  end
end