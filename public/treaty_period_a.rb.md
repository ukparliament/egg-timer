# A method for calculating the end date for treaty period A.

The calculation counts a day whenever both Houses have a parliamentary sitting day, requiring the laying date and the number of days to count.

Calculation defined by [Constitutional Reform and Governance Act 2010 section 20 paragraph 2](https://www.legislation.gov.uk/ukpga/2010/25/part/2#section-20-2)

## We start counting on the **first day when both Houses have a parliamentary sitting**.

This **does not** include the laying day of the instrument.

We continue to the **day immediately following** the laying day.

If that day is or is followed by a joint parliamentary sitting day...

... we set the date to the day of the first joint parliamentary sitting day **following** the laying day.

... we've found the first joint parliamentary sitting day so we start counting from day 1.

... whilst the number of days we’re counting is less than the target number of days to count ...

... continue to the **next day**.

... and add 1 to the day count if this is a joint parliamentary sitting day.

... if the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

If **day immediately following** the laying day is not a joint parliamentary sitting day **and** is not followed by a joint parliamentary sitting day...

.. this error message is displayed to users.

Return the anticipated end date of the scrutiny period for display.

