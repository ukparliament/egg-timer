module Calculations
  module Backwards
    module BicameralSiEitherHouseSitting

      # # A method for calculating the start date of a scrutiny period, based on days on which **either** House must be sitting or on a short adjournment.
      # This method is used for:
      # * made affirmative Statutory Instruments as set out in their enabling Act, for example: [paragraph 4 of section 55 of the Sanctions and Anti-Money Laundering Act 2018](https://www.legislation.gov.uk/ukpga/2018/13/section/55#section-55-4)
      # * bicameral negative Statutory Instruments as set out in [paragraph 1 Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1)
      # * proposed draft remedial orders, draft affirmative remedial orders and made affirmative remedial orders as set out in [Schedule 2 of the Human Rights Act 1998](https://www.legislation.gov.uk/ukpga/1998/42/schedule/2#schedule-2)
      def bicameral_si_either_house_sitting_calculation_backwards( target_end_date, target_day_count )
      
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
      
        # We set the day count to zero.
        day_count = 0
      
        # ## Whilst the number of days we’re counting is less than the target number of days to count ...
        while day_count < target_day_count

          # ... we move to the **previous day**.
          date = date.prev_day
        
          # If the day is a scrutiny day in either House ...
          if date.is_either_house_scrutiny_day?
          
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

        # Return the anticipated start date of the scrutiny period for display.
        date
      end
    end
  end
end