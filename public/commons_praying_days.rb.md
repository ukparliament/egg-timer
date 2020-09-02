# A method for calculating the end date of scrutiny periods during which the House of Commons must be sitting or on a short adjournment, used for House of Commons only draft and made affirmative Statutory Instruments.

The calculation counts a day whenever the House of Commons has a praying day, requiring the laying date and the number of days to count.

## We start counting on the **first day when the House of Commons has a praying day**.

This may include the laying day of the instrument.

Unless the laying day is a House of Commons praying day, then ...

... if there is a future House of Commons praying day ...

... we set the date to that day.

If we didn't find a **future House of Commons praying day** in our calendar, we can't calculate the scrutiny period, ...

... this error message is displayed ...

... and we stop looking for a scrutiny period end date.

Otherwise, we've established the laying day is a House of Commons praying day so we don't have to cycle through the calendar to find a subsequent one.

We've found the first House of Commons praying day so we start counting from day 1.

## Whilst the number of days we’re counting is less than the target number of days to count ...

... continue to the **next day**.

... and add 1 to the day count if this is a House of Commons praying day.

... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

Return the anticipated end date of the scrutiny period for display.

