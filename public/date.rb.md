# A monkey patched Ruby date class to handle UK Parliament specific day types.
## A set of methods to work out the type of a given day.
### We want to check if this is a praying sitting day in the Commons.
We use a naive definition of a sitting day: this includes a calendar day when the Commons sits, together with following calendar days if the Commons sat through the night.
For example: if the Commons sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as praying sitting days. 
If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.
### We want to check if this is a praying sitting day in the Lords.
We use a naive definition of a sitting day: this includes a calendar day when the Lords sits, together with following calendar days if the Lords sat through the night.
For example: if the Lords sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as praying sitting days.
If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.
### We want to check if this is a parliamentary sitting day in the Commons. 
We use a more strict definition of a sitting day. We don’t include dates for which the Commons continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.
### We want to check if this is a parliamentary sitting day in the Lords.
We use a more strict definition of a sitting day. We don’t include dates for which the Lords continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.
### We want to check if this is a virtual sitting day in the Commons.
This is a day where all Members of the House sit ‘digitally’, rather than physically.
A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.
As of the end of June 2020, the Commons has had no virtual sitting days.
### We want to check if this is a virtual sitting day in the Lords.
This is a day where all Members of the House sit ‘digitally’, rather than physically.
A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.
### We want to check if this is a praying sitting day in either House.
### We want to check if this is a praying sitting day in both Houses.
### We want to check if this is a parliamentary sitting day in either House.
### We want to check if this is a parliamentary sitting day in both Houses.
### We want to check if this is an adjournment day in either House.
### We want to check if this is an adjournment day in the Commons.
### We want to check if this is an adjournment day in the Lords.
### We want to check if Parliament is prorogued on this day.
### We want to check if Parliament is dissolved on this day.
### We want to check if this is a day for which we have something in the calendar.
That might be a parliamentary sitting day, a praying sitting day, a virtual sitting day, an adjournment day, a day within prorogation or a day within dissolution.
### We want to check if this is a day for which we do not have anything in the calendar.
We use this to check if we've "run out of calendar" so we don't keep cycling into future days and loop infinitely.
This is our event horizon.
### We want to check if this is a praying adjournment day in the Commons.
During a short adjournment, adjournment days are praying days.
This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.
In all known cases “short” is defined as not more than four days.
For the purposes of calculating praying days, virtual sitting days count as adjournment days.
### We want to check if this is a Commons adjournnment day or a Commons virtual sitting day.
Having found that this is a Commons adjournnment day or a Commons virtual sitting day, we start the adjournment day count at 1.
We want to cycle through the following days until we reach the maximum day count passed into this function.
Go forward one day.
If this is a Commons adjournnment day or a Commons virtual sitting day ...
... add one to the adjournment day count.
If this is not a Commons adjournnment day or a Commons virtual sitting day ...
... stop cycling through following days.
We want to cycle through the preceding days until we reach the maximum day count passed into this function.
Go back one day.
If this is a Commons adjournnment day or a Commons virtual sitting day ...
... add one to the adjournment day count.
If this is not a Commons adjournnment day or a Commons virtual sitting day ...
... stop cycling through preceding days.
If the total number of continuous adjournment days is more than the maximum day count ...
... then this day is not part of a short adjournment and so does not count as a praying day.
If the total number of continuous adjournment days is less than or the same as the maximum day count ...
... then this day is part of a short adjournment and so does count as a praying day.
Returns if this day is a part of a Commons short adjournment
We want to check if this is a praying day in the Commons.
A praying day in the Commons is either a praying sitting day in the Commons, or a praying adjournment day in the Commons.
We pass '4' as the maximum day count to the adjournment day calculation, because praying adjournment days are days within a series of not more than four adjournment days.
We want to check if this is a praying adjournment day in the Lords.
During a short adjournment, adjournment days are praying days.
This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.
In all known cases “short” is defined as not more than four days.
For the purposes of calculating praying days, virtual sitting days count as adjournment days.
We want to check if this is a Lords adjournnment day or a Lords virtual sitting day.
Having found that this is a Lords adjournnment day or a Lords virtual sitting day, we start the adjournment day count at 1.
We want to cycle through the following days until we reach the maximum day count passed into this function.
Go forward one day.
If this is a Lords adjournnment day or a Lords virtual sitting day ...
... add one to the adjournment day count.
If this is not a Lords adjournnment day or a Lords virtual sitting day ...
... stop cycling through following days.
We want to cycle through the preceding days until we reach the maximum day count passed into this function.
Go back one day.
If this is a Lords adjournnment day or a Lords virtual sitting day ...
... add one to the adjournment day count.
If this is not a Lords adjournnment day or a Lords virtual sitting day ...
... stop cycling through preceding days.
If the total number of continuous adjournment days is more than the maximum day count ...
... then this day is not part of a short adjournment and so does not count as a praying day.
If the total number of continuous adjournment days is less than or the same as the maximum day count ...
... then this day is part of a short adjournment and so does count as a praying day.
Returns if this day is a part of a Lords short adjournment
We want to check if this is a praying day in the Lords.
A praying day in the Lords is either a praying sitting day in the Lords, or a praying adjournment day in the Lords.
We pass '4' as the maximum day count to the adjournment day calculation, because praying adjournment days are days within a series of not more than four adjournment days.
We want to check if this is a praying day in either House.
We want to check if this is a praying day in both Houses.
End of set of methods to work out the type of a given day.
A set of methods to find the first day of a given type.
We want to find the first praying day in either House.
This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. In such cases, the clock starts from the first praying sitting day in either House following the laying.
This method is used for bicameral negative SIs - and bicameral made affirmatives where the enabling legislation specifies that either House can be sitting.
If this is a day on which the calendar is not yet populated ...
... then we cannot find a first praying day so we stop looking.
If this is a day on which the calendar is populated ...
... then if this is not a praying day in either House ...
... then go to the next day and check that.
... then if this is a praying day in either House ...
... then return this day as the first praying day in either House.
We want to find the first praying day in both Houses.
This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first praying sitting day in both Houses following the laying.
This method is used for bicameral made affirmatives where the enabling legislation specifies that both Houses must be sitting.
If this is a day on which the calendar is not yet populated ...
... then we cannot find a first praying day so we stop looking.
If this is a day on which the calendar is populated ...
... then if this is not a praying day in both Houses ...
... then go to the next day and check that.
... then if this is a praying day in both Houses ...
... then return this day as the first praying day in both Houses.
We want to find the first praying day in the Commons.
This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first praying sitting day in the Commons following the laying.
This method is used for negative or made affirmative SIs - laid in the Commons and not laid in the Lords.
If this is a day on which the calendar is not yet populated ...
... then we cannot find a first Commons praying day so we stop looking.
If this is a day on which the calendar is populated ...
... then if this is not a praying day in the Commons ...
... then go to the next day and check that.
... then if this is a praying day in the Commons ...
... then return this day as the first praying day in the Commons.
We want to find the first parliamentary sitting day in both Houses.
This method is used when a Proposed Negative Statutory Instrument is laid.
Even if a PNSI is laid on a joint parliamentary sitting day, the clock does not start until the next joint parliamentary sitting day.
If this is a day on which the calendar is not yet populated ...
... then we cannot find a first parliamentary sitting day in both Houses so we stop looking.
If this is a day on which the calendar is populated ...
... then if this is not a parliamentary sitting day in both Houses ...
... then go to the next day and check that.
... then if this is a parliamentary sitting day in both Houses ...
... then return this day as the first parliamentary sitting day in both Houses.
We want to find the first parliamentary sitting day in the Commons.
This method is used when a motion to not ratify a treaty in either House is approved - and the Government make a statement that the treaty should nonetheless be ratified, triggering treaty scrutiny period B.
Treaty scrutiny period B starts on the first Commons parliamentary sitting day following the date of the Government statement.
If this is a day on which the calendar is not yet populated ...
... then we cannot find a first parliamentary sitting day in the Commons so we stop looking.
If this is a day on which the calendar is populated ...
... then if this is not a parliamentary sitting day in the Commons ...
... then go to the next day and check that.
... then if this is a parliamentary sitting day in the Commons ...
... then return this day as the first parliamentary sitting day in the Commons.
End of set of methods to find the first day of a given type.
Generate label for the day type in the Commons in a session.
Generate label for the day type in the Lords in a session.
Generate a label to say whether it's a praying day in the Commons or not.
Generate a label to say whether it's a praying day in the Lords or not.
