module Calculations
  module Backwards
    module CommonsOnlySi
    
      # # A method for calculating the start date of a scrutiny period, based on days on which the House of Commons must be sitting or on a short adjournment.
      # This method is used for:
      # * Commons only negative Statutory Instruments as set out by the Statutory Instruments Act 1946
      # * Commons only made affirmative Statutory Instruments as set out by their enabling Act
      # The calculation is set out in paragraphs 1 and 2 of [Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7).
      # A different calculation may be required if the instrument is laid under another Act - as set out in [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).
      def commons_only_si_calculation_backwards( target_end_date, target_day_count )
      
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
        
        # We set the day count to zero.
        day_count = 0
      
        # ## Whilst the number of days we’re counting is less than the target number of days to count ...
        while day_count < target_day_count

          # ... we move to the **previous day**.
          date = date.prev_day
        
          # If the day is a Commons scrutiny day ...
          if date.is_commons_scrutiny_day?
          
            # ... if we've not set the scrutiny end date ...
            unless @scrutiny_end_date
            
              # ... we set the scrutiny end date to this date.
              @scrutiny_end_date = date
            end
          
            # We add 1 to the day count.
            day_count += 1
          
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
