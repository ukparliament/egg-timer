# A method for calculating scrutiny periods during which **both** Houses must be sitting or on a short adjournment, used for made affirmative Statutory Instruments where this is set out by their enabling Act.

25th August 2020 - there are two possible interpretations of this rule: to calculate whether both Houses are on a praying day and if so count it; or to calculate joint sitting days and determine joint praying days from this, then count those. This method currently uses the former. A meeting with the Speaker’s Counsel has been arranged to check this logic.

The calculation counts a day whenever both Houses have a praying day, requiring the laying date and the number of days to count.

## We start counting on the **first day when both Houses have a praying day**.

This may include the laying day of the instrument.

Unless the laying day is a joint praying day ...

If there is a future praying day in the Commons or the Lords

... we look for the next joint praying day. If there is a subsequent joint praying day ...

... we set the date to that day.

If we didn't find a **future joint praying day** in our calendar, we can't calculate the scrutiny period, ...

... this error message is displayed ...

... and we stop looking for a scrutiny period end date.

Otherwise, we've established the laying day is a joint praying day so we don't have to cycle through the calendar to find a subsequent one.

We've found the first joint praying day so we start counting from day 1.

## Whilst the number of joint praying days we’re counting is less than the target number of days to count ...

... continue to the **next day**.

... and add 1 to the day count if this is a joint praying day.

... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

Return the anticipated end date of the scrutiny period for display.

