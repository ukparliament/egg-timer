module Calculations
  module BicameralBothHousesSittingReverse

    # # A method for calculating the start date of scrutiny periods during which **both** Houses must be sitting or on a short adjournment, used for made affirmative Statutory Instruments as set out by their enabling Act. Also used for Legislative Reform Orders, Public Body Orders, Localism Orders and enhanced affirmatives under the Investigatory Powers Act 2016.
    # [Paragraph 1 of section 7 of the Statutory Instrument Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1) sets out that - in calculating the scrutiny period for an SI under that Act - “no account shall be taken of any time during which Parliament is dissolved or prorogued or during which *both* Houses are adjourned for more than four days.” This applies to the majority of made affirmative instruments.
    # Made affirmatives laid under different Acts follow other rules, for example: [paragraph 9 of section 5 of the National Insurance Contributions Act 2014](https://www.legislation.gov.uk/ukpga/2014/7/section/5/enacted#section-5-9), sets out that “no account is to be taken of any time [..] during which either House is adjourned for more than 4 days."
    # This calculation deals with the case where days are not counted if *either* House is adjourned for more than four days.
    # The rules governing the time periods for Legislative Reform Orders are set out in sections [18](https://www.legislation.gov.uk/ukpga/2006/51/section/18#section-18) and [19](https://www.legislation.gov.uk/ukpga/2006/51/section/19#section-19) of the Legislative and Regulatory Reform Act 2006.
    # The rules governing the time period for Public Body Orders are set out in [paragraph 12 of section 11 of the Public Bodies Act 2011](https://www.legislation.gov.uk/ukpga/2011/24/section/11#section-11-12).
    # The rules governing the time period for Localism Orders are set out in [paragraph 14 of section 19 of the Localism Act 2011](https://www.legislation.gov.uk/ukpga/2011/20/enacted#section-19-14).
    # The rules governing the time period for published drafts are set out in [paragraph 14 of schedule 8 of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/8/enacted#schedule-8-paragraph-14).
    # The rules governing the time period for enhanced affirmatives under the [Investigatory Powers Act 2016](https://www.legislation.gov.uk/id/ukpga/2016/25/) are set out in [paragraph 11 of section 268 of the Investigatory Powers Act 2016](https://www.legislation.gov.uk/ukpga/2016/25/section/268#section-268-11).

    def bicameral_calculation_both_houses_sitting_reverse( date, target_day_count )
    
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
        
        # If the day is a scrutiny day in both Houses ...
        if date.is_joint_scrutiny_day?
          
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