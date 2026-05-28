module Calculations
  module BicameralSiEitherHouseSittingReverse

    # # A method for calculating the start date of a scrutiny period, based on days on which **either** House must be sitting or on a short adjournment.
    # This method is used for bicameral negative Statutory Instruments as set out by the Statutory Instruments Act 1946 and for made affirmative Statutory Instruments as set out by their enabling Act.
    # The calculation is set out in [paragraph 1 Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1), though a different calculation may be required if the instrument is laid under another Act - as per [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).
    # This method is also used for calculations of scrutiny periods for proposed draft remedial orders and draft affirmative remedial orders and for scrutiny and approval periods for made affirmative remedial orders as set out in [Schedule 2 of the Human Rights Act 1998](https://www.legislation.gov.uk/ukpga/1998/42/schedule/2#schedule-2).
    # The calculation counts in actual sitting days, requiring the start date and the number of days to count.

    def bicameral_si_either_house_sitting_calculation_reverse( date, target_day_count )
      
      # We set the scrutiny start date, being the start date of the calculation and the end date of the scrutiny period.
      @scrutiny_start_date = nil
      
      # We go forward one day.
      date = date.next
      
      # We set the day count to zero.
      day_count = 0
      
      # ## Whilst the number of days we’re counting is less than the target number of days to count ...
      while day_count < target_day_count

        # ... we continue to the **previous day**.
        date = date.prev_day
        
        # If the day is a scrutiny day in either House ...
        if date.is_either_house_scrutiny_day?
          
          # ... we set the scrutiny start date to this date if the scrutiny start date is nil ...
          @scrutiny_start_date = date if @scrutiny_start_date.nil?
          
          # ... and add 1 to the day count.
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