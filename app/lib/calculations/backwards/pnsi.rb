module Calculations
  module Backwards
    module Pnsi

      # # A method for calculating the start date of committee scrutiny periods for Proposed Negative Statutory Instruments (PNSIs).
      # The calculation is set out in the [European Union (Withdrawal) Act 2018 schedule 7 paragraph 17(10)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10) (number of days to count) and [paragraph 17(11)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-11) (definition of sitting day).
      # The same calculation is also set out in:
      # * [paragraph 8 of schedule 5 of the European Union (Future Relationship) Act 2020](https://www.legislation.gov.uk/ukpga/2020/29/schedule/5#schedule-5-paragraph-8)
      # * [paragraph 6 of schedule 5 of the Retained EU Law (Revocation and Reform) Act 2023](https://www.legislation.gov.uk/ukpga/2023/28/schedule/5#schedule-5-paragraph-6)
      def pnsi_calculation_backwards( target_end_date, target_day_count )
    
        # PNSIs are considered by both Houses, so we'll get ready to start counting the sitting days in each House.
      	commons_day_count = 0
        lords_day_count = 0
        
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
        
        # ## The total day count is 10 days of which:
        # * the last nine sitting days are counted when *each* House is sitting. Both Houses must have sat for nine days, but these do not need to be joint sitting days.
        # * the first day is counted when *both* Houses are sitting - a joint sitting day.
        
        # We subtract one from the target day count in order to count to nine sitting days in *each* House.
        target_day_count = target_day_count - 1
        
        # Whilst the Commons day count is less than the target day count *or* the Lords day count is less than the target day count ...
        while ( ( commons_day_count < target_day_count ) or (lords_day_count < target_day_count ) )
        
          # ... we move back to the **previous day**.
          date = date.prev_day
          
          # If this is a sitting day in either House...
          if date.is_either_house_parliamentary_sitting_day?
          
            # ... if we've not set the scrutiny end date ...
            unless @scrutiny_end_date
            
              # ... we set the scrutiny end date to this date.
              @scrutiny_end_date = date
            end
            
            # If this is a sitting day in the Lords ...
            if date.is_lords_parliamentary_sitting_day?
            
              # ... we add a day to the Lords’ count
              lords_day_count +=1
            end
            
            # If this is a sitting day in the Commons ...
            if date.is_commons_parliamentary_sitting_day?
            
              # ... we add a day to the Commons’ count
              commons_day_count +=1
            end
          end
        
          # If the calendar has no record of what type of day this is, we can't calculate the start date, ...
          if date.is_calendar_not_populated?

            # ... this error message is displayed to users ...
            @error_message = "It's not currently possible to calculate an anticipated start date, as that date occurs during a period for which no sitting day information is available."
          
            # ... and we stop looking through the calendar.
            break
          end
        end
        
        # ## We've now counted nine sitting days in both the Commons and the Lords.
        # The first day of the scrutiny period must be a joint sitting day, as set out in [paragraph 17 (10) (a) of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10-a) ...
        # ... so we find the last joint sitting day preceding the date we've counted to.
        date.last_joint_parliamentary_sitting_day
      
        # We return the anticipated start date of the scrutiny period for display.
        date
      end
    end
  end
end