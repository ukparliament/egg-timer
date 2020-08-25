# A method for calculating scrutiny periods for Legislative Reform Orders (LROs), Localism Orders (LOs) and Public Body Orders (PBOs).

The calculation counts a day whenever both Houses have a parliamentary sitting day, requiring the laying date and the number of days to count.

## We start counting on the **first day when both Houses have a parliamentary sitting**.

This may include the laying day of the instrument.

Unless the laying day is a joint parliamentary sitting day ...

... we look for the next parliamentary sitting day. If there is a subsequent joint parliamentary sitting day ...

... we set the date to that day.

If we didn't find a **future joint parliamentary sitting day** in our calendar, we can't calculate the scrutiny period, ...

... this error message is displayed ...

... and we stop looking for a scrutiny period end date.

Otherwise, we've established the laying day is a joint parliamentary sitting day so we don't have to cycle through the calendar to find a subsequent one.

We've found the first joint parliamentary sitting day so we start counting from day 1.

## Whilst the number of parliamentary sitting days we’re counting is less than the target number of days to count ...

... continue to the **next day**.

... and add 1 to the day count if this is a joint parliamentary sitting day.

... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

Return the anticipated end date of the scrutiny period for display.

