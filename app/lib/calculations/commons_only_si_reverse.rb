module Calculations
  module CommonsOnlySiReverse
    # # A method for calculating the end date of a scrutiny period, based on days on which the House of Commons must be sitting or on a short adjournment. This method is used for Commons only negative Statutory Instruments as set out by the Statutory Instruments Act 1946 and for made affirmative Statutory Instruments as set out by their enabling Act.
    # The calculation counts in actual sitting days, requiring the start date and the number of days to count.
    # The calculation is defined by paragraphs 1 and 2 of [Section 7 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7), though a different calculation may be required if the instrument is laid under another Act - as per [paragraph 3](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-3).

    def commons_only_si_calculation_reverse(date, target_day_count)
      # ## We start counting on the **first day the House of Commons has a scrutiny day**.
      # For negative Statutory Instruments this will be the day on which the instrument was laid, if that day was a scrutiny day. For made negative Statutory Instruments, this is defined by the [Statutory Instruments Act 1946 Section 5 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1). For draft negative Statutory Instruments, this is defined by the [Statutory Instruments Act 1946 Section 6 paragraph 1](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/6#section-6-1).
      # For made affirmatives this will be the day on which the instrument was made, if that day was a scrutiny day.
      
      # We set the scrutiny start date, being the start date of the calculation and the end date of the scrutiny period.
      @scrutiny_start_date = nil
      
      # We go forward one day.
      date = date.next
      
      # We set the day count to zero.
      day_count = 0
      
      # ## Whilst the number of days we’re counting is less than the target number of days to count ...
      while day_count < target_day_count

        # ... continue to the **previous day**.
        date = date.prev_day
        
        # If the day is a Commons scrutiny day ...
        if date.is_commons_scrutiny_day?
          
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

      # Return the anticipated end date of the scrutiny period for display.
      date
    end
  end
end
