# A method for calculating the end date of committee scrutiny periods for Proposed Negative Statutory Instruments (PNSIs).

The calculation counts in parliamentary sitting days, requiring the laying date and the number of days to count.

Calculation defined by [European Union (Withdrawal) Act 2018 schedule 7 paragraph 17(10)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-10) and [European Union (Withdrawal) Act 2018 schedule 7 paragraph 17(11)](https://www.legislation.gov.uk/ukpga/2018/16/schedule/7/enacted#schedule-7-paragraph-17-11)

## We start counting on the **first day when both Houses have a parliamentary sitting following the laying of the instrument**.

If the date of laying day is a joint parliamentary sitting day, we do not count that day.

If we find a day meeting that criteria ...

... we set the date to start counting from as that day.

PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.

The first joint sitting day counts as day 1, so we count from 1 rather than from 0.

## We look at subsequent days, ensuring that we've counted at least the set number of sitting days in each House. In the case of a PNSI, that's ten days.

While there are still days on which the Commons **or** Lords have sat for fewer than 10 days, we continue counting days ...

... continue to the **next day**.

PNSIs use parliamentary sitting days, rather than naive calendar days.

If the Lords sat on the date we've found, we add another day to the Lords’ count.

If the Commons sat on the date we've found, we add another day to the Commons’ count.

If the calendar has no record of what type of day this is, we can't calculate the end date, ...

... this error message is displayed to users ...

... and we stop looking through the calendar.

If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period ...

... and this error message is displayed.

Return the anticipated end date of the scrutiny period for display.

