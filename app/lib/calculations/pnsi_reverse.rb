module Calculations
  module PnsiReverse

    # # A method for calculating the start date of committee scrutiny periods for Proposed Negative Statutory Instruments (PNSIs).
    # The calculation counts in parliamentary sitting days, requiring the laying date and the number of days to count.
    # The calculation is defined by the [European Union (Withdrawal) Act 2018 schedule 7 paragraph 17(10)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10) (number of days to count) and [paragraph 17(11)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-11) (definition of sitting day).
    def pnsi_calculation_reverse( date, target_day_count )
    
      # PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
      # The first joint sitting day counts as day 1 in both Houses, so we count from 1 rather than from 0.
    	commons_day_count = 0
      lords_day_count = 0
      
      # We set the scrutiny start date, being the start date of the calculation and the end date of the scrutiny period.
      @scrutiny_start_date = nil
      
      # We go back forward one day.
      date = date.next
      
      # ## We look at preceding days, ensuring that we've counted at least nine parliamentary sitting days in each House.
      # The total day count in each House must be 10 days and the first day of scrutiny must be a *joint sitting day*.
      # We'll handle the first day of scrutiny later.
      # For now, we take the target count of 10 days and remove one day, that being the *joint sitting day*.
      until ( ( commons_day_count >= target_day_count - 1 ) and ( lords_day_count >= target_day_count - 1 ) ) do

        # ... continue to the **previous day**.
        date = date.prev_day
        
        puts date
        
        # PNSIs use parliamentary sitting days, rather than naive sitting days.
        # If this is a parliamentary sitting day in either House...
        if date.is_either_house_parliamentary_sitting_day?
        
        puts "sitting"
          
          # ... we set the scrutiny start date to this date if the scrutiny start date is nil ...
          @scrutiny_start_date = date if @scrutiny_start_date.nil?

          # If the Lords sat on the date we've found, we add a day to the Lords’ count.
          lords_day_count +=1 if date.is_lords_parliamentary_sitting_day?
        
          # If the Commons sat on the date we've found, we add a day to the Commons’ count.
          commons_day_count+=1 if date.is_commons_parliamentary_sitting_day?
        end
        
        # If the calendar has no record of what type of day this is, we can't calculate the end date, ...
        if date.is_calendar_not_populated?

          # ... this error message is displayed to users ...
          @error_message = "It's not currently possible to calculate an anticipated start date, as the likely start date occurs during a period for which no sitting day information is available."

          # ... and we stop looking through the calendar.
          break
        end
      end
      
      # We've now counted 10 sitting days in each House.
      # According to [paragraph 17 (10) (a) of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10-a), the first day of the scrutiny period must be a joint sitting day.
      # We find the last joint sitting day preceding the date we've counted to.
      date.last_joint_parliamentary_sitting_day
      
      # We return the anticipated start date of the scrutiny period for display.
      date
    end
  end
end