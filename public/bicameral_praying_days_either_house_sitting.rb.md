# A method for calculating the end date of scrutiny periods during which **either** House must be sitting or on a short adjournment, used for Commons and Lords negative Statutory Instruments and made affirmative SIs where this is set out by their enabling Act.

The calculation counts a day whenever either House has a praying day, requiring the laying date and the number of days to count.

## We start counting on the **first day when either House has a praying day**.

This may include the laying day of the instrument.

Unless the laying day is a praying day in either House, then ...

... if there is a future praying day in either House ...

... we set the date to that day.

If we didn't find a **future praying day in either House** in our calendar, we can't calculate the scrutiny period, ...

... this error message is displayed ...

... and we stop looking for a scrutiny period end date.

Otherwise, we've established the laying day is a praying day in at least one House, so we don't have to cycle through the calendar to find a subsequent one.

We've found the first praying day in either House so we start counting from day 1.

## Whilst the number of praying days we’re counting is less than the target number of days to count ...

... continue to the **next day**.

... and add 1 to the day count if this is a praying day in either House.

... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

Return the anticipated end date of the scrutiny period for display.

