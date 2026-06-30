module Calculations
  module Forwards
    module Pnsi

      # # A method for calculating the end date of committee scrutiny periods for Proposed Negative Statutory Instruments (PNSIs).
      # The calculation is set out in the [European Union (Withdrawal) Act 2018 schedule 7 paragraph 17(10)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10) (number of days to count) and [paragraph 17(11)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-11) (definition of sitting day).
      # The same calculation is also set out in:
      # * [paragraph 8 of schedule 5 of the European Union (Future Relationship) Act 2020](https://www.legislation.gov.uk/ukpga/2020/29/schedule/5#schedule-5-paragraph-8)
      # * [paragraph 6 of schedule 5 of the Retained EU Law (Revocation and Reform) Act 2023](https://www.legislation.gov.uk/ukpga/2023/28/schedule/5#schedule-5-paragraph-6)
      def pnsi_calculation_forwards( date, target_day_count )
      
        # The PNSI calculation begins on "the first day on which both Houses of Parliament are sitting *after* the day on which the PNSI was laid before each House of Parliament".
        # For that reason, we go forward one day.
        date = date.next_day
        
        # If there is a future joint sitting day ...
        if date.first_joint_parliamentary_sitting_day
        
          # ... we set the date to the first future joint sitting day ...
          date = date.first_joint_parliamentary_sitting_day

          # ... and set the scrutiny start date to this date.
          @scrutiny_start_date = date
          
          # PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
          # The first joint sitting day counts as day 1 in both Houses, so we count from 1 rather than from 0.
        	commons_day_count = 1
          lords_day_count = 1
          
          # While we have not counted 10 days in the House of Commons *and* 10 days in the House of Lords ...
          while ( ( commons_day_count < 10 ) and (lords_day_count < 10 ) )
          
            # ... we continue to the **next day**.
            date = date.next_day
            
            # If the Lords sat on the date we've found ....
            if date.is_lords_parliamentary_sitting_day?
            
              # ... we add a day to the Lords’ count.
              lords_day_count +=1
            end
            
            # If the Commons sat on the date we've found ...
            if date.is_commons_parliamentary_sitting_day?
            
              # ... we add a day to the Commons’ count.
              commons_day_count+=1
            end

            # If the calendar has no record of what type of day this is, we can't calculate the end date, ...
            if date.is_calendar_not_populated?

              # ... this error message is displayed to users ...
              @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."

              # ... and we stop looking through the calendar.
              break
            end
          end

        # If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period ...
        else

          # ... and this error message is displayed.
          @error_message = "Unable to find a future joint sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        end

        # Return the anticipated end date of the scrutiny period for display.
        date
      end
    end
  end
end