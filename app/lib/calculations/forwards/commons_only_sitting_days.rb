module Calculations
  module Forwards
    module CommonsOnlySittingDays

      # # A method for calculating the end date of scrutiny periods for National Policy Statements (NPS).
      # The calculation is set out in [section 5 (4A) of the Planning Act 2008](https://www.legislation.gov.uk/ukpga/2008/29/section/5#section-5-4A).
      # The NPS calculation begins on "the first sitting day *after* the day on which the statement is laid before Parliament".
      def commons_only_sitting_days_forwards( date, target_day_count )
      
        # We set the day count to zero.
        day_count = 0
      
        # While the number of days we’ve counted is less than the target number of days to count ...
        while ( day_count < target_day_count )
        
          # ... we continue to the **next day**.
          date = date.next_day
          
          # If the day is a Commons sitting day ...
          if date.is_commons_parliamentary_sitting_day?
          
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