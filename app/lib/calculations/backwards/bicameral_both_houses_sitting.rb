module Calculations
  module Backwards
    module BicameralBothHousesSitting

      # # A method for calculating the start date of scrutiny periods during which **both** Houses must be sitting or on a short adjournment.
      # This method deals with the case where days are not counted if *either* House is adjourned for more than four days.
      # This method is used for:
      # * made affirmative Statutory Instruments as set out in their enabling Act, for example: [paragraph 9 of section 5 of the National Insurance Contributions Act 2014](https://www.legislation.gov.uk/ukpga/2014/7/section/5/enacted#section-5-9)
      # * Legislative Reform Orders as set out in sections [18](https://www.legislation.gov.uk/ukpga/2006/51/section/18#section-18) and [19](https://www.legislation.gov.uk/ukpga/2006/51/section/19#section-19) of the Legislative and Regulatory Reform Act 2006
      # * Public Body Orders as set out in [paragraph 12 of section 11 of the Public Bodies Act 2011](https://www.legislation.gov.uk/ukpga/2011/24/section/11#section-11-12)
      # * Localism Orders as set out in [paragraph 14 of section 19 of the Localism Act 2011](https://www.legislation.gov.uk/ukpga/2011/20/enacted#section-19-14)
      # * published drafts as set out in [paragraph 14 of schedule 8 of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/8/enacted#schedule-8-paragraph-14)
      # * enhanced affirmatives under the [Investigatory Powers Act 2016](https://www.legislation.gov.uk/id/ukpga/2016/25/) as set out in [paragraph 11 of section 268 of the Investigatory Powers Act 2016](https://www.legislation.gov.uk/ukpga/2016/25/section/268#section-268-11)
      def bicameral_calculation_both_houses_sitting_backwards( target_end_date, target_day_count )
    
        # Because the start of each loop causes the date to move to the preceding day and we wish to include the target end date ...
        #  ... we go forward one day.
        date = target_end_date.next
    
        # We set the day count to zero.
        day_count = 0
      
        # ## Whilst the number of days we’re counting is less than the target number of days to count ...
        while day_count < target_day_count

          # ... we move to the **previous day**.
          date = date.prev_day
        
          # If the day is a joint scrutiny day ...
          if date.is_joint_scrutiny_day?
          
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