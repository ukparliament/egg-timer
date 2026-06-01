module Calculations
  module Interval

    # # A method to calculate the number of sitting days in each House between two dates.
    # The method is passed the start and end dates entered by the user.
    # The calculation is inclusive of the start and end dates.
    def calculate_sitting_days_in_interval( start_date, end_date )

      # We set the date to start counting from the start date.
      date = start_date

      # Whilst the date is not later than the end date ...
      while date <= end_date
      
        #  ... if the calendar has no record of what type of day this is, we can't calculate the the number of sitting days, ...
        if date.is_calendar_not_populated?

          # ... this error message is displayed to users ...
          @error_message = "It is not currently possible to calculate the number of sitting days, because the interval includes days for which the calendar is not populated."
          
          # ... and we stop looking through the calendar.
          break
          
        # Otherwise, if the calendar does have a record of what type of day this is ...
        else
          
          # ... if the date is a sitting day in the Commons ...
          if date.is_commons_parliamentary_sitting_day?

            # ... we increment the Commons sitting day count.
            @commons_sitting_day_count += 1
          end

          # If the date is a sitting day in the Lords ...
          if date.is_lords_parliamentary_sitting_day?

            # ... we increment the Lords sitting day count.
            @lords_sitting_day_count += 1
          end

          # We continue to the **next day**.
          date = date.next_day
        end
      end
    end
  end
end