module CALCULATION_BICAMERAL_BOTH_HOUSES_SITTING
# A method for calculating the end date of scrutiny periods during which **both** Houses must be sitting or on a short adjournment, used for made affirmative Statutory Instruments as set out by their enabling Act. Also used for Legislative Reform Orders, Public Body Orders and Localism Orders.

[Paragraph 1 of section 7 of the Statutory Instrument Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/7#section-7-1) sets out that - in calculating the scrutiny period for an SI under that Act - “no account shall be taken of any time during which Parliament is dissolved or prorogued or during which *both* Houses are adjourned for more than four days.” This applies to the majority of made affirmative instruments.

Made affirmatives laid under different Acts follow other rules, for example: [paragraph 9 of section 5 of the National Insurance Contributions Act 2014](https://www.legislation.gov.uk/ukpga/2014/7/section/5/enacted#section-5-9), sets out that “no account is to be taken of any time [..] during which either House is adjourned for more than 4 days."

This calculation deals with the case where days are not counted if *either* House is adjourned for more than four days.

The rules governing the time period for Legislative Reform Orders are set out in [section 19 of the Legislative and Regulatory Reform Act 2006](https://www.legislation.gov.uk/ukpga/2006/51/section/19#section-19).

The rules governing the time period for Public Body Orders are set out in [paragraph 12 of section 11 of the Public Bodies Act 2011](https://www.legislation.gov.uk/ukpga/2011/24/section/11#section-11-12).

The rules governing the time period for Localism Orders are set out in [paragraph 14 of section 19 of the Localism Act 2011](https://www.legislation.gov.uk/ukpga/2011/20/enacted#section-19-14).

The rules governing the time period for published drafts are set out in [paragraph 14 of schedule 8 of the European Union (Withdrawal) Act 2018](https://www.legislation.gov.uk/ukpga/2018/16/schedule/8/enacted#schedule-8-paragraph-14).

  def bicameral_calculation_both_houses_sitting( date, target_day_count )
## We start counting on the **first day both Houses have a scrutiny day**.

For Legislative Reform Orders, Public Body Orders and Localism Orders this will be the day on which the instrument was laid, if that day was a scrutiny day.

For published drafts under the European Union (Withdrawal) Act 2018, this will be the day on which the draft was published, if that day was a scrutiny day. This is set out in [paragraph 14(2) of Schedule 8 of the European Union (Withdrawal) Act 2018 ](https://www.legislation.gov.uk/ukpga/2018/16/schedule/8/enacted#schedule-8-paragraph-14-2).

For made affimatives this will be the day on which the instrument was made, if that day was a scrutiny day.

For instruments covered by this calculation, lacking explicit instructions in enabling Acts, we decide to take the definition from [paragraph 1 of section 5 of the Statutory Instruments Act 1946](https://www.legislation.gov.uk/ukpga/Geo6/9-10/36/section/5#section-5-1).

If the laying day - or making day for a made affirmative - is a joint scrutiny day, we don't have to cycle through the calendar to find a subsequent one ...

    if date.is_joint_scrutiny_day?
... and the laying or making day is the start of the scrutiny period.

      @scrutiny_start_date = date
Otherwise, the laying or making day is not a joint scrutiny day, then ...

    else
... if there is a future joint scrutiny day ...

      if date.first_joint_scrutiny_day
... we set the date to that day.

        date = date.first_joint_scrutiny_day
... we have found the start of the scrutiny period.

        @scrutiny_start_date = date
If we didn't find a **future joint scrutiny day** in our calendar, we can't calculate the scrutiny period, ...

      else
... this error message is displayed ...

        @error_message = "Unable to find a future joint scrutiny day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
... and we stop looking for a scrutiny period end date.

        return
      end
    end
We've found the first joint scrutiny day so we start counting from day 1.

    day_count = 1
## Whilst the number of joint scrutiny days we’re counting is less than the target number of days to count ...

    while ( day_count < target_day_count ) do
... continue to the **next day**.

      date = date.next_day
... and add 1 to the day count if this is a joint scrutiny day.

      day_count +=1 if date.is_joint_scrutiny_day?
... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

      if date.is_calendar_not_populated?
... this error message is displayed to users ...

        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
... and we stop looking through the calendar.

        break
      end
    end
Return the anticipated end date of the scrutiny period for display.

    date
  end
end