# A monkey patched Ruby date class to handle UK Parliament specific day types.

class Date
## A set of methods to work out the type of a given day.

### We want to check if this is an actual sitting day in the Commons.

We use a naive definition of a sitting day: this includes a calendar day when the Commons sits, together with following calendar days if the Commons sat through the night.

For example: if the Commons sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as actual sitting days. 

If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.

  def is_commons_actual_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
### We want to check if this is an actual sitting day in the Lords.

We use a naive definition of a sitting day: this includes a calendar day when the Lords sits, together with following calendar days if the Lords sat through the night.

For example: if the Lords sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as actual sitting days.

If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.

  def is_lords_actual_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
### We want to check if this is a parliamentary sitting day in the Commons. 

We use a more strict definition of a sitting day. We don’t include dates for which the Commons continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.

  def is_commons_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
  end
### We want to check if this is a parliamentary sitting day in the Lords.

We use a more strict definition of a sitting day. We don’t include dates for which the Lords continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.

  def is_lords_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
  end
### We want to check if this is a virtual sitting day in the Commons.

This is a day where all Members of the House sit ‘digitally’, rather than physically.

A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.

As of the end of June 2020, the Commons has had no virtual sitting days.

  def is_commons_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
### We want to check if this is a virtual sitting day in the Lords.

This is a day where all Members of the House sit ‘digitally’, rather than physically.

A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.

  def is_lords_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
### We want to check if this is an actual sitting day in *either* House.

  def is_either_house_actual_sitting_day?
    self.is_commons_actual_sitting_day? or self.is_lords_actual_sitting_day?
  end
### We want to check if this is an actual sitting day in *both* Houses.

  def is_joint_actual_sitting_day?
    self.is_commons_actual_sitting_day? and self.is_lords_actual_sitting_day?
  end
### We want to check if this is a parliamentary sitting day in *either* House.

  def is_either_house_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? or self.is_lords_parliamentary_sitting_day?
  end
### We want to check if this is a parliamentary sitting day in *both* Houses.

  def is_joint_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
  end
### We want to check if this is an adjournment day in either House.

  def is_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end
### We want to check if this is an adjournment day in the Commons.

  def is_commons_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 1 ).first
  end
### We want to check if this is an adjournment day in the Lords.

  def is_lords_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 2 ).first
  end
### We want to check if Parliament is prorogued on this day.

  def is_prorogation_day?
    ProrogationDay.all.where( 'date = ?',  self ).first
  end
### We want to check if Parliament is dissolved on this day.

  def is_dissolution_day?
    DissolutionDay.all.where( 'date = ?',  self ).first
  end
### We want to check if this is a day for which we have something in the calendar.

That may be an actual sitting day - including parliamentary sitting days, a virtual sitting day, an adjournment day, a day within prorogation or a day within dissolution.

  def is_calendar_populated?
    self.is_commons_actual_sitting_day? or self.is_lords_actual_sitting_day? or self.is_commons_virtual_sitting_day? or self.is_lords_virtual_sitting_day? or self.is_adjournment_day? or self.is_prorogation_day? or self.is_dissolution_day?
  end
### We want to check if this is a day for which we do not have anything in the calendar.

We use this to check if we've "run out of calendar" so we don't keep cycling into future days and loop infinitely.

This is our event horizon.

  def is_calendar_not_populated?
    !self.is_calendar_populated?
  end
### Methods to calculate non-sitting scrutiny days in both Houses.

In [guidance issued on 16-04-2020](https://committees.parliament.uk/publications/688/documents/33426/default/) the Lords Procedure Committee stated, "A Virtual Proceeding is not a sitting of the House."

Whilst clerks state that a virtual sitting day does not count as a sitting day for the purposes of calculating scrutiny periods, lawyers imply this would need to be tested in court.

Unless and until this is resolved, these methods use the clerks' definition of non-sitting scrutiny day.

### We want to check if this is a non-sitting scrutiny day in the Commons.

During a short adjournment, adjournment days count toward the scrutiny period.

This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.

In all known cases “short” is defined as not more than four days.

For the purposes of calculating non-sitting scrutiny days, virtual sitting days also count.

  def is_commons_non_sitting_scrutiny_day?( maximum_day_count )
#### We want to check if this is a Commons adjournnment day or a Commons virtual sitting day.

    if self.is_commons_adjournment_day? or self.is_commons_virtual_sitting_day?
Having found that this is a Commons adjournnment day or a Commons virtual sitting day, we start the adjournment day count at 1.

      non_sitting_scrutiny_day_count = 1
We want to cycle through the following days until we reach the maximum day count passed into this function.

      date = self
      for i in ( 1..maximum_day_count )
Go forward one day.

        date = date.next_day
If this is a Commons adjournnment day or a Commons virtual sitting day ...

        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
... add one to the non-sitting scrutiny day count.

          non_sitting_scrutiny_day_count +=1
If this is not a Commons adjournnment day or a Commons virtual sitting day ...

        else
... stop cycling through following days.

          break
        end
      end
We want to cycle through the preceding days until we reach the maximum day count passed into this function.

      date = self
      for i in ( 1..maximum_day_count )
Go back one day.

        date = date.prev_day
If this is a Commons adjournnment day or a Commons virtual sitting day ...

        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
... add one to the non-sitting scrutiny day count.

          non_sitting_scrutiny_day_count +=1
If this is not a Commons adjournnment day or a Commons virtual sitting day ...

        else  
... stop cycling through preceding days.

          break
        end
      end
If the total number of continuous non-sitting scrutiny days is more than the maximum day count ...

      if non_sitting_scrutiny_day_count > maximum_day_count
... then this day does not count as a non-sitting scrutiny day.

        is_commons_non_sitting_scrutiny_day = false
If the total number of continuous non-sitting scrutiny days is less than or the same as the maximum day count ...

      else
... then this day does count as a non-sitting scrutiny day.

        is_commons_non_sitting_scrutiny_day = true
      end
Returns if this day is a Commons non-sitting scrutiny day

      is_commons_non_sitting_scrutiny_day
    end
  end
### We want to check if this is a non-sitting scrutiny day in the Lords.

During a short adjournment, adjournment days count toward the scrutiny period.

This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.

In all known cases “short” is defined as not more than four days.

For the purposes of calculating non-sitting scrutiny days, virtual sitting days also count.

  def is_lords_non_sitting_scrutiny_day?( maximum_day_count )
### We want to check if this is a Lords adjournnment day or a Lords virtual sitting day.

    if self.is_lords_adjournment_day? or self.is_lords_virtual_sitting_day?
Having found that this is a Lords adjournnment day or a Lords virtual sitting day, we start the adjournment day count at 1.

      non_sitting_scrutiny_day_count = 1
We want to cycle through the following days until we reach the maximum day count passed into this function.

      date = self
      for i in ( 1..maximum_day_count )
Go forward one day.

        date = date.next_day
If this is a Lords adjournnment day or a Lords virtual sitting day ...

        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
... add one to the non-sitting scrutiny day count.

          non_sitting_scrutiny_day_count +=1
If this is not a Lords adjournnment day or a Lords virtual sitting day ...

        else
... stop cycling through following days.

          break
        end
      end
We want to cycle through the preceding days until we reach the maximum day count passed into this function.

      date = self
      for i in ( 1..maximum_day_count )
Go back one day.

        date = date.prev_day
If this is a Lords adjournnment day or a Lords virtual sitting day ...

        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
... add one to the non-sitting scrutiny day count.

          non_sitting_scrutiny_day_count +=1
If this is not a Lords adjournnment day or a Lords virtual sitting day ...

        else  
... stop cycling through preceding days.

          break
        end
      end
If the total number of continuous non-sitting scrutiny days is more than the maximum day count ...

      if non_sitting_scrutiny_day_count > maximum_day_count
... then this day does not count as a non-sitting scrutiny day.

        is_lords_non_sitting_scrutiny_day = false
If the total number of continuous non-sitting scrutiny days is less than or the same as the maximum day count ...

      else
... then this day does count as a non-sitting scrutiny day.

        is_lords_non_sitting_scrutiny_day = true
      end
Returns if this day is a Lords non-sitting scrutiny day

      is_lords_non_sitting_scrutiny_day
    end
  end
(End of methods to calculate non-sitting scrutiny days in both Houses.)

### We want to check if this is a scrutiny day in the Commons.

A scrutiny day in the Commons is either an actual sitting day in the Commons, or a non-sitting scrutiny day in the Commons.

We pass '4' as the maximum day count to the non-sitting scrutiny day calculation, because non-sitting scrutiny days are days within a series of not more than four non-sitting days.

  def is_commons_scrutiny_day?
    self.is_commons_actual_sitting_day? or self.is_commons_non_sitting_scrutiny_day?( 4 )
  end
### We want to check if this is a scrutiny day in the Lords.

A scrutiny day in the Lords is either an actual sitting day in the Lords, or a non-sitting scrutiny day in the Lords.

We pass '4' as the maximum day count to the non-sitting scrutiny day calculation, because  non-sitting scrutiny days are days within a series of not more than four non-sitting days.

  def is_lords_scrutiny_day?
    self.is_lords_actual_sitting_day? or self.is_lords_non_sitting_scrutiny_day?( 4 )
  end
### We want to check if this is a scrutiny day in *either* House.

  def is_either_house_scrutiny_day?
    self.is_commons_scrutiny_day? or self.is_lords_scrutiny_day?
  end
### We want to check if this is a scrutiny day in *both* Houses.

  def is_joint_scrutiny_day?
    self.is_commons_scrutiny_day? and self.is_lords_scrutiny_day?
  end
(End of set of methods to work out the type of a given day.)

## A set of methods to find the first day of a given type.

### We want to find the first scrutiny day in *either* House.

This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during a non-sitting period of more than four days, or during a period in which Parliament is prorogued. In such cases, the clock starts from the first actual sitting day in either House following the laying.

This method is used for bicameral negative SIs - and bicameral made affirmatives where the enabling legislation specifies that either House can be sitting.

  def first_scrutiny_day_in_either_house
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first scrutiny day so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not a scrutiny day in *either* House ...

      unless self.is_either_house_scrutiny_day?
... then go to the next day and check that.

        self.next_day.first_scrutiny_day_in_either_house
... then if this is a scrutiny day in either House ...

      else
... then return this day as the first scrutiny day in either House.

        self
      end
    end
  end
### We want to find the first scrutiny day in *both* Houses.

This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first actual sitting day in both Houses following the laying.

This method is used for bicameral made affirmatives where the enabling legislation specifies that both Houses must be sitting.

  def first_joint_scrutiny_day
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first scrutiny day so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not a scrutiny day in both Houses ...

      unless self.is_joint_scrutiny_day?
... then go to the next day and check that.

        self.next_day.first_joint_scrutiny_day
... then if this is a scrutiny day in both Houses ...

      else
... then return this day as the first scrutiny day in both Houses.

        self
      end
    end
  end
### We want to find the first scrutiny day in the Commons.

This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first actual sitting day in the Commons following the laying.

This method is used for negative or made affirmative SIs - laid in the Commons and not laid in the Lords.

  def first_commons_scrutiny_day
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first Commons scrutiny day so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not a scrutiny day in the Commons ...

      unless self.is_commons_scrutiny_day?
... then go to the next day and check that.

        self.next_day.first_commons_scrutiny_day
... then if this is a scrutiny day in the Commons ...

      else
... then return this day as the first scrutiny day in the Commons.

        self
      end
    end
  end
### We want to find the first parliamentary sitting day in both Houses.

This method is used when a Proposed Negative Statutory Instrument is laid.

Even if a PNSI is laid on a joint parliamentary sitting day, the clock does not start until the next joint parliamentary sitting day.

  def first_joint_parliamentary_sitting_day
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first parliamentary sitting day in both Houses so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not a parliamentary sitting day in both Houses ...

      unless self.is_joint_parliamentary_sitting_day?
... then go to the next day and check that.

        self.next_day.first_joint_parliamentary_sitting_day
... then if this is a parliamentary sitting day in both Houses ...

      else
... then return this day as the first parliamentary sitting day in both Houses.

        self
      end
    end
  end
### We want to find the first actual sitting day in both Houses.

This method is used to calculate periods A and B for treaties.

Even if a treaty is laid or a ministerial statement is made on a joint actual sitting day, the clock does not start until the next joint actual sitting day.

  def first_joint_actual_sitting_day
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first actual sitting day in both Houses so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not an actual sitting day in both Houses ...

      unless self.is_joint_actual_sitting_day?
... then go to the next day and check that.

        self.next_day.first_joint_actual_sitting_day
... then if this is an actual sitting day in both Houses ...

      else
... then return this day as the first actual sitting day in both Houses.

        self
      end
    end
  end
### We want to find the first actual sitting day in the House of Commons.

This method is used by the House of Commons only sitting day calculation.

Even if an instrument is laid on a House of Commons actual sitting day, the clock does not start until the next House of Commons actual sitting day.

  def first_commons_actual_sitting_day
If this is a day on which the calendar is not yet populated ...

    if self.is_calendar_not_populated?
... then we cannot find a first actual sitting day in the House of Commons so we stop looking.

      return nil
If this is a day on which the calendar is populated ...

    else
... then if this is not an actual sitting day in the House of Commons ...

      unless self.is_commons_actual_sitting_day?
... then go to the next day and check that.

        self.next_day.first_commons_actual_sitting_day
... then if this is an actual sitting day in the House of Commons ...

      else
... then return this day as the first actual sitting day in the House of Commons.

        self
      end
    end
  end
(End of set of methods to find the first day of a given type.)

## A set of methods to return which higher level parliamentary time periods a calendar day sits in.

A calendar day may sit in either a dissolution period or a Parliament period.

If a calendar day sits inside a Parliament period, it may sit inside either a session or a prorogation period.

### We want to find which dissolution period a calendar day sits in, if any.

  def dissolution_period
    DissolutionPeriod.all.where( "start_date <= ?", self ).where( "end_date >= ?", self).first
  end
### We want to find which Parliament period a calendar day sits in, if any.

  def parliament_period
    ParliamentPeriod.find_by_sql(
      "
        SELECT *
        FROM parliament_periods
        WHERE start_date <= '#{self}'
        AND (
          end_date >= '#{self}'
          OR
          end_date IS NULL
        )
      "
    ).first
  end
### We want to find which prorogoration period a calendar day sits in, if any.

  def prorogation_period
    ProrogationPeriod.all.where( "start_date <= ?", self ).where( "end_date >= ?", self).first
  end
### We want to find which session a calendar day sits in, if any.

  def session
    Session.find_by_sql(
      "
        SELECT *
        FROM sessions
        WHERE start_date <= '#{self}'
        AND (
          end_date >= '#{self}'
          OR
          end_date IS NULL
        )
      "
    ).first
  end
## We want to find out if this is the final day of a session.

  def is_final_day_of_session?
    is_final_day_of_session = false
    session = Session.all.where( "end_date = ?", self )
    is_final_day_of_session = true unless session.empty?
    is_final_day_of_session
  end
## We want to find the session immediately preceding this date.

  def preceding_session
    Session.all.where( "start_date < ?", self ).order( "start_date DESC" ).first
  end
## We want to find the session immediately following this date.

This method is used to determine which session papers laid in prorogation are recorded in.

  def following_session
    Session.all.where( "start_date > ?", self ).order( "start_date" ).first
  end
### Generate label for the day type in the Commons in a session.

  def commons_day_type
    if self.is_commons_parliamentary_sitting_day?
      day_type = 'Parliamentary sitting day'
    elsif self.is_commons_actual_sitting_day?
      day_type = "Continuation sitting day"
    elsif self.is_commons_virtual_sitting_day?
      day_type = 'Virtual sitting day'
    elsif self.is_commons_non_sitting_scrutiny_day?( 4 )
      day_type = 'Scrutiny non-sitting day'
    elsif self.is_commons_adjournment_day?
      day_type = self.commons_adjournment_day_label
    elsif self.is_prorogation_day?
      day_type = 'Prorogation'
    elsif self.is_dissolution_day?
      day_type = 'Dissolution'
    end
    day_type
  end
### Generate label for the day type in the Lords in a session.

  def lords_day_type
    if self.is_lords_parliamentary_sitting_day?
      day_type = 'Parliamentary sitting day'
    elsif self.is_lords_actual_sitting_day?
      day_type = "Continuation sitting day"
    elsif self.is_lords_virtual_sitting_day?
      day_type = 'Virtual sitting day'
    elsif self.is_lords_non_sitting_scrutiny_day?( 4 )
      day_type = 'Scrutiny non-sitting day'
    elsif self.is_lords_adjournment_day?
      day_type = self.lords_adjournment_day_label
    elsif self.is_prorogation_day?
      day_type = 'Prorogation'
    elsif self.is_dissolution_day?
      day_type = 'Dissolution'
    end
    day_type
  end
### Generate a label to say whether it's a scrutiny day in the Commons or not.

  def is_commons_scrutiny_day_label
    if self.is_commons_scrutiny_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
### Generate a label to say whether it's a scrutiny day in the Lords or not.

  def is_lords_scrutiny_day_label
    if self.is_lords_scrutiny_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
### A method to label a Commons adjournment day, with recess if applicable.

  def commons_adjournment_day_label
    commons_adjournment_day_label = 'Adjournment day'
We attempt to find a recess on this date, in this House.

    recess_date = RecessDate
      .all
      .where( "start_date <= ?", self )
      .where( "end_date >= ?", self )
      .where( house_id: 1 )
      .first
If we find a recess date on this day, in this House ...

    if recess_date
... we append the description of the recess date to the label

      commons_adjournment_day_label += ' (' + recess_date.description + ')'
    end
    commons_adjournment_day_label
  end
### A method to label a Lords adjournment day, with recess if applicable.

  def lords_adjournment_day_label
    lords_adjournment_day_label = 'Adjournment day'
We attempt to find a recess on this date, in this House.

    recess_date = RecessDate
      .all
      .where( "start_date <= ?", self )
      .where( "end_date >= ?", self )
      .where( house_id: 2 )
      .first
If we find a recess date on this day, in this House ...

    if recess_date
... we append the description of the recess date to the label

      lords_adjournment_day_label += ' (' + recess_date.description + ')'
    end
    lords_adjournment_day_label
  end
end