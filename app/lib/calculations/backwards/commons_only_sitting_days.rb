module Calculations
  module Backwards
    module CommonsOnlySittingDays
    
      # # A method for calculating the start date of scrutiny periods for National Policy Statements (NPS).
      # The calculation is set out in [section 5 (4A) of the Planning Act 2008](https://www.legislation.gov.uk/ukpga/2008/29/section/5#section-5-4A).
      def commons_only_sitting_days_backwards( target_end_date, target_day_count )
      
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
      
        # We set the day count to zero.
        day_count = 0
      
        # Whilst the number of days we’re counting is less than the target number of days to count ...
        while day_count < target_day_count

          # ... we move back to the **previous day**.
          date = date.prev_day
        
          # If the date is sitting day in the House of Commons ...
          if date.is_commons_parliamentary_sitting_day?
          
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