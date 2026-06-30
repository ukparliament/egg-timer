module Calculations
  module Forwards
    module CommonsOnlySi
    
      # # A method for calculating the end date of a scrutiny period, based on days on which the House of Commons must be sitting or on a short adjournment.
      # This method is used for:
      # * Commons only negative Statutory Instruments as set out by the Statutory Instruments Act 1946
      # * Commons only made affirmative Statutory Instruments as set out by their enabling Act
      # The calculation is set out in paragraphs 1 and 2 of [Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7).
      # A different calculation may be required if the instrument is laid under another Act - as set out in [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).
      def commons_only_si_calculation_forwards( date, target_day_count )
      
        # For an instrument laid under the draft or made negative procedure, the calculation *may* start on the date of laying, if that is a House of Commons scrutiny day.
        # For an instrument laid under the made affirmative procedure, the calculation *may* start on the date of making, if that is a House of Commons scrutiny day.
        # The following loop starts by moving to the next day.
        # For that reason, we move back to the **previous day**.
        date = date.prev_day
        
        # We set the day count to zero.
        day_count = 0
        
        # While the number of days we’ve counted is less than the target number of days to count ...
        while ( day_count < target_day_count )
        
          # ... we continue to the **next day**.
          date = date.next_day
          
          # If the day is a Commons scrutiny day ...
          if date.is_commons_scrutiny_day?
          
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