module Calculations
  module Forwards
    module BicameralBothHousesSitting

      # # A method for calculating the end date of scrutiny periods during which **both** Houses must be sitting or on a short adjournment.
      # This method deals with the case where days are not counted if *either* House is adjourned for more than four days.
      # This method is used for:
      # * made affirmative Statutory Instruments as set out in their enabling Act, for example: [paragraph 9 of section 5 of the National Insurance Contributions Act 2014](https://www.legislation.gov.uk/ukpga/2014/7/section/5/enacted#section-5-9)
      # * Legislative Reform Orders as set out in sections [18](https://www.legislation.gov.uk/ukpga/2006/51/section/18#section-18) and [19](https://www.legislation.gov.uk/ukpga/2006/51/section/19#section-19) of the Legislative and Regulatory Reform Act 2006
      # * Public Body Orders as set out in [paragraph 12 of section 11 of the Public Bodies Act 2011](https://www.legislation.gov.uk/ukpga/2011/24/section/11#section-11-12)
      # * Localism Orders as set out in [paragraph 14 of section 19 of the Localism Act 2011](https://www.legislation.gov.uk/ukpga/2011/20/enacted#section-19-14)
      # * published drafts as set out in [paragraph 14 of schedule 8 of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/8/enacted#schedule-8-paragraph-14)
      # * enhanced affirmatives under the [Investigatory Powers Act 2016](https://www.legislation.gov.uk/id/ukpga/2016/25/) as set out in [paragraph 11 of section 268 of the Investigatory Powers Act 2016](https://www.legislation.gov.uk/ukpga/2016/25/section/268#section-268-11)
      def bicameral_calculation_both_houses_sitting_forwards( date, target_day_count )
      
      
        # For an instrument laid under the made affirmative procedure, the calculation *may* start on the date of making, if that is a joint scrutiny day.
        # For an instrument laid under the Legislative Reform Order procedure, Public Body Order procedure, Localism Order procedure, published draft procedure or the enhanced affirmative procedure, the calculation *may* start on the date of laying, if that is a joint scrutiny day.
        # The following loop starts by moving to the next day.
        # For that reason, we move back to the **previous day**.
        date = date.prev_day
        
        # We set the day count to zero.
        day_count = 0
        
        # While the number of days we’ve counted is less than the target number of days to count ...
        while ( day_count < target_day_count )
        
          # ... we continue to the **next day**.
          date = date.next_day
          
          # If the day is a joint scrutiny day ...
          if date.is_joint_scrutiny_day?
          
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