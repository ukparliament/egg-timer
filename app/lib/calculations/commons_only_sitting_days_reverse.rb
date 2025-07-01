module Calculations
  module CommonsOnlySittingDaysReverse

    # # A method for calculating the start date for delegated legislation laid into the House of Commons only, taking account of sitting days.
    # The calculation counts a day whenever the House of Commons has an actual sitting day - and requires the start date and the number of days to count.
    # The calculation is set out in [section 5 (4A) of the Planning Act 2008](https://www.legislation.gov.uk/ukpga/2008/29/section/5#section-5-4A).

    def commons_only_sitting_days_reverse( date, target_day_count )
      
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
        
        # If the date is actual sitting day in the House of Commons ...
        if date.is_commons_actual_sitting_day?
          
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