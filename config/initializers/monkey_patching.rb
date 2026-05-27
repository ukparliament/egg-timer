# # A monkey patched Ruby date class to handle UK Parliament specific day types.
module DateMonkeyPatch

  # See also: [Parliamentary Time Period ontology](https://ukparliament.github.io/ontologies/time-period/time-period-ontology)
  
  # ## A Venn diagram of parliamentary time
  
  # <a href="/egg-timer/day-type-venn.png" title="A Venn diagram of parliamentary time"><img src="/egg-timer/day-type-venn.png" alt="A Venn diagram of parliamentary time" /></a>

  # ## A set of methods to determine the type of a given day across both Houses.
  
  # ### We want to determine if Parliament is dissolved on this day.
  def is_dissolution_day?
    DissolutionDay.all.where( 'date = ?',  self ).first
  end
  
  # ### We want to determine if Parliament is prorogued on this day.
  def is_prorogation_day?
    ProrogationDay.all.where( 'date = ?',  self ).first
  end
  
  # ## A set of methods to return the parliamentary time periods a calendar day forms part of.
  # A calendar day forms part of a dissolution period or a Parliament period.
  # Where a calendar day forms part of a Parliament period, it forms part of a session or a prorogation period.
  
  # ### We want to find which Parliament period a calendar day forms part of, if any.
  def parliament_period
    ParliamentPeriod.find_by_sql([
      "
        SELECT *
        FROM parliament_periods
        WHERE start_date <= :the_date
        AND (
          end_date >= :the_date
          OR
          end_date IS NULL
        )
      ",
      the_date: self
    ]).first
  end

  # ### We want to find which dissolution period a calendar day forms part of, if any.
  def dissolution_period
    DissolutionPeriod.all.where( "start_date <= ?", self ).where( "end_date >= ?", self).first
  end
  
  #### We want to find which session a calendar day forms part of, if any.
  def session
    Session.find_by_sql([
      "
        SELECT *
        FROM sessions
        WHERE start_date <= :the_date
        AND (
          end_date >= :the_date
          OR
          end_date IS NULL
        )
      ",
      the_date: self
    ]).first
  end

  # ### We want to find which prorogation period a calendar day forms part of, if any.
  def prorogation_period
    ProrogationPeriod.all.where( "start_date <= ?", self ).where( "end_date >= ?", self).first
  end
  
  
  # ## A set of methods to determine the type of a given day in a House.
  
  # ### Sitting days
  
  # Parliamentary clerks define a sitting day in a House as a day when the House started sitting. Should a House start sitting on a Monday, continue sitting through the night, rise on the Tuesday and not start sitting again on that Tuesday, that would count as one sitting day.
  # As far as we are aware, this definition made its first appearance in legislation as part of [schedule 5, paragraph 44 (2) of the European Union (Withdrawal Agreement) Act 2020](https://www.legislation.gov.uk/ukpga/2020/1#schedule-5-paragraph-44-2).
  # Clerks have suggested that this definition would apply across all calculations of scrutiny periods. Lawyers have suggested otherwise.
  # The Parliamentary Time application defines three types of sitting day:
  # * a parliamentary sitting day, being a day on which a House started sitting according to the definition given above.
  # * a calendar sitting day, being a day on which a House sat, regardless of whether it started sitting on that date.
  # * a continuation sitting day, being a day on which a House sat when it did not start sitting on that date.
  
  # #### We want to determine if this is a parliamentary sitting day in the Commons.
  def is_commons_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
  end
  
  # #### We want to determine if this is a parliamentary sitting day in the Lords.
  def is_lords_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
  end
  
  # #### We want to determine if this is a calendar sitting day in the Commons.
  # This method is never called so is commented out here.
  def is_commons_calendar_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # #### We want to determine if this is a calendar sitting day in the Lords.
  # This method is never called so is commented out here.
  def is_lords_calendar_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # #### We want to determine if this is a continuation sitting day in the Commons.
  def is_commons_continuation_sitting_day?
    SittingDay.all.where( 'start_date < ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # #### We want to determine if this is a continuation sitting day in the Lords.
  def is_lords_continuation_sitting_day?
    SittingDay.all.where( 'start_date < ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  
  # ### Virtual sitting days
  
  # During the COVID pandemic, the House of Lords sat virtually for 11 days.
  # As of February 2026, the House of Commons has never sat virtually.
  # In [guidance issued on 16 April 2020](https://committees.parliament.uk/publications/688/documents/33426/default/) the Lords Procedure Committee stated:
  # "A Virtual Proceeding is not a sitting of the House. There is no Mace present and the Virtual Proceeding will not be empowered to make decisions. Virtual Proceedings can debate and sc[r]utinise an issue but when a decision is needed that must be taken by the House."
  # Whilst clerks state that a virtual sitting day does not count as a sitting day for the purposes of calculating scrutiny periods, lawyers imply this would need to be tested in court.
  # Unless and until this is resolved, these methods use the clerks' definition of non-sitting scrutiny day.
  
  # #### We want to determine if this is a virtual sitting day in the Commons.
  def is_commons_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end

  # #### We want to determine if this is a virtual sitting day in the Lords.
  def is_lords_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  
  # ### Adjournment days
  
  # #### We want to determine if this is an adjournment day in the Commons.
  def is_commons_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 1 ).first
  end

  # #### We want to determine if this is an adjournment day in the Lords.
  def is_lords_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 2 ).first
  end
  
  
  # ### Adjourned days
  # Days on which a House is adjourned encompass more day types than those declared as adjournment days in the calendar.
  # According to the guidance set out by the Lords Procedure Committee - given above - days on which a House sat virtually also count as adjourned days.
  # According to the definition of a parliamentary sitting day - also given above - as understood by clerks and as set out in *some* legislation, continuation sitting days also count as adjourned days.
  
  # #### We want to determine if the day counts as the Commons being adjourned.
  def counts_as_commons_adjourned_day?
    self.is_commons_adjournment_day? \
    or self.is_commons_virtual_sitting_day? \
    or self.is_commons_continuation_sitting_day?
  end
  
  # #### We want to determine if the day counts as the Lords being adjourned.
  def counts_as_lords_adjourned_day?
    self.is_lords_adjournment_day? \
    or self.is_lords_virtual_sitting_day? \
    or self.is_lords_continuation_sitting_day?
  end
  
  
  # ## A set of methods to determine the type of a given day in *either* House.
  
  # ### We want to determine if this is a parliamentary sitting day in *either* House.
  def is_either_house_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).first
  end
  
  # ### We want to determine if this is a calendar sitting day in *either* House.
  def is_either_house_calendar_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?', self).first
  end
  
  # ### We want to determine if this is an adjournment day in either House.
  def is_either_house_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end
  
  
  # ## A set of methods to determine if this is a joint sitting day.
  
  # ### We want to check if this is a parliamentary sitting day in *both* Houses.
  def is_joint_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
  end
  
  # ### We want to determine if this is a calendar sitting day in *both* Houses.
  def is_joint_calendar_sitting_day?
    self.is_commons_calendar_sitting_day? and self.is_lords_calendar_sitting_day?
  end
  
  
  # ## A set of methods to determine if the calendar is populated.
  
  # ### A method to determine if this is a day for which we have something in the calendar.
  # That may be:
  # * a day within dissolution
  # * a day within prorogation
  # * a parliamentary sitting day
  # * a calendar sitting day
  # * a virtual sitting day
  # * an adjournment day
  def is_calendar_populated?
    self.is_dissolution_day? \
    or self.is_prorogation_day? \
    or self.is_commons_calendar_sitting_day? \
    or self.is_lords_calendar_sitting_day? \
    or self.is_commons_virtual_sitting_day? \
    or self.is_lords_virtual_sitting_day? \
    or self.is_commons_adjournment_day? \
    or self.is_lords_adjournment_day?
  end
  
  # ### We want to determine if this is a day for which we do not have anything in the calendar.
  # This method is used to determine whether a calculation has enough calendar data to proceed.
  # If the calendar is not populated for a date, calculations cannot proceed past that date.
  def is_calendar_not_populated?
    !self.is_calendar_populated?
  end
  
  
  # ## A set of methods to determine whether a date forms part of a break in sitting days of a determined length.
  # Under *some* legislation, periods where the Houses are adjourned for a defined number of days count as scrutiny days for instruments laid under powers in that legislation.
  # In the legislation we've encountered where this is set out, such periods are defined as being not more than four days.
  # These methods allow the calculation to be adjusted by passing in a maximum day count.
  
  # ### Methods to calculate non-sitting scrutiny days in both Houses.
  
  # #### We want to check if this is a non-sitting scrutiny day in the Commons.
  def is_commons_non_sitting_scrutiny_day?( maximum_day_count )
  
    # If this counts as an adjourned day in the Commons ...
    if self.counts_as_commons_adjourned_day?

      # ... we start the non-sitting scrutiny day count at 1.
      non_sitting_scrutiny_day_count = 1

      # We want to cycle through the following days until we reach the maximum day count passed into this function.
      date = self
      
      # For each number between 1 and the maximum day count ...
      for i in ( 1 .. maximum_day_count )

        # ... we go forward one day.
        date = date.next_day

        # If this day counts as an adjourned day in the Commons ...
        if date.counts_as_commons_adjourned_day?

          # ... we add one to the non-sitting scrutiny day count.
          non_sitting_scrutiny_day_count += 1

        # Otherwise, if this day does not count as an adjourned day in the Commons ...
        else

          # ... we stop cycling through following days.
          break
        end
      end

      # We want to cycle through the preceding days until we reach the maximum day count passed into this function.
      date = self
      
      # For each number between 1 and the maximum day count ...
      for i in ( 1 .. maximum_day_count )

        # ... we go back one day.
        date = date.prev_day
        
        # If this day counts as an adjourned day in the Commons ...
        if date.counts_as_commons_adjourned_day?

          # ... we add one to the non-sitting scrutiny day count.
          non_sitting_scrutiny_day_count += 1

        # Otherwise, if this day does not count as an adjourned day in the Commons ...
        else

          # ... we stop cycling through preceding days.
          break
        end
      end

      # If the total number of non-sitting scrutiny days is more than the maximum day count ...
      if non_sitting_scrutiny_day_count > maximum_day_count

        # ... then this day *does not* count as a non-sitting scrutiny day.
        is_commons_non_sitting_scrutiny_day = false

      # If the total number of non-sitting scrutiny days is less than or the same as the maximum day count ...
      else

        # ... then this day *does* count as a non-sitting scrutiny day.
        is_commons_non_sitting_scrutiny_day = true
      end

      # We return if this day is a Commons non-sitting scrutiny day
      is_commons_non_sitting_scrutiny_day
    end
  end
  
  # #### We want to check if this is a non-sitting scrutiny day in the Lords.
  def is_lords_non_sitting_scrutiny_day?( maximum_day_count )
  
    # If this counts as an adjourned day in the Lords ...
    if self.counts_as_lords_adjourned_day?

      # ... we start the non-sitting scrutiny day count at 1.
      non_sitting_scrutiny_day_count = 1

      # We want to cycle through the following days until we reach the maximum day count passed into this function.
      date = self
      
      # For each number between 1 and the maximum day count ...
      for i in ( 1 .. maximum_day_count )

        # ... we go forward one day.
        date = date.next_day

        # If this day counts as an adjourned day in the Lords ...
        if date.counts_as_lords_adjourned_day?

          # ... we add one to the non-sitting scrutiny day count.
          non_sitting_scrutiny_day_count += 1

        # Otherwise, if this day does not count as an adjourned day in the Lords ...
        else

          # ... we stop cycling through following days.
          break
        end
      end

      # We want to cycle through the preceding days until we reach the maximum day count passed into this function.
      date = self
      
      # For each number between 1 and the maximum day count ...
      for i in ( 1 .. maximum_day_count )

        # ... we go back one day.
        date = date.prev_day
        
        # If this day counts as an adjourned day in the Lords ...
        if date.counts_as_lords_adjourned_day?

          # ... we add one to the non-sitting scrutiny day count.
          non_sitting_scrutiny_day_count += 1

        # Otherwise, if this day does not count as an adjourned day in the Lords ...
        else

          # ... we stop cycling through preceding days.
          break
        end
      end

      # If the total number of non-sitting scrutiny days is more than the maximum day count ...
      if non_sitting_scrutiny_day_count > maximum_day_count

        # ... then this day *does not* count as a non-sitting scrutiny day.
        is_lords_non_sitting_scrutiny_day = false

      # If the total number of non-sitting scrutiny days is less than or the same as the maximum day count ...
      else

        # ... then this day *does* count as a non-sitting scrutiny day.
        is_lords_non_sitting_scrutiny_day = true
      end

      # We return if this day is a Lord non-sitting scrutiny day
      is_lords_non_sitting_scrutiny_day
    end
  end
  
  # ## A set of methods to determine if this is a scrutiny day in a House, in both Houses and in either House.
  
  # ### We want to determine if this is a scrutiny day in the Commons.
  def is_commons_scrutiny_day?
    
    # We set the Commons is scrutiny day boolean to false.
    is_commons_scrutiny_day = false
    
    # If this is a parliamentary sitting day in the Commons ...
    # ... or this is a non-sitting scrutiny day in the Commons ...
    if self.is_commons_parliamentary_sitting_day? or self.is_commons_non_sitting_scrutiny_day?( 4 ) # We pass '4' as the maximum day count to the non-sitting scrutiny day calculation, because non-sitting scrutiny days are days within a series of not more than four non-sitting days.
    
      # ... we set the is Commons scrutiny day boolean to true.
      is_commons_scrutiny_day = true
    end
    
    # We return the is Commons scrutiny day boolean.
    is_commons_scrutiny_day
  end
  
  # ### We want to determine if this is a scrutiny day in the Lords.
  def is_lords_scrutiny_day?
    
    # We set the Lords is scrutiny day boolean to false.
    is_lords_scrutiny_day = false
    
    # If this is a parliamentary sitting day in the Lords ...
    # ... or this is a non-sitting scrutiny day in the Lords ...
    if self.is_lords_parliamentary_sitting_day? or self.is_lords_non_sitting_scrutiny_day?( 4 ) # We pass '4' as the maximum day count to the non-sitting scrutiny day calculation, because non-sitting scrutiny days are days within a series of not more than four non-sitting days.
    
      # ... we set the Lords is scrutiny day boolean to true.
      is_lords_scrutiny_day = true
    end
    
    # We return the Lords is scrutiny day boolean.
    is_lords_scrutiny_day
  end
  
  # ### We want to check if this is a scrutiny day in *both* Houses.
  def is_joint_scrutiny_day?
  
    # We set the is joint scrutiny day boolean to false.
    is_joint_scrutiny_day = false
    
    # If this is a scrutiny day in the Commons *and* this is a scrutiny day in the Lords ...
    if self.is_commons_scrutiny_day? and self.is_lords_scrutiny_day?
  
      # ... we set the is joint scrutiny day boolean to true.
      is_joint_scrutiny_day = true
    end
    
    # We return the is joint scrutiny day boolean.
    is_joint_scrutiny_day
  end
  
  # ### We want to check if this is a scrutiny day in *either* House.
  def is_either_house_scrutiny_day?
  
    # We set the is either house scrutiny day boolean to false.
    is_either_house_scrutiny_day = false
    
    # If this is a scrutiny day in the Commons *or* this is a scrutiny day in the Lords ...
    if self.is_commons_scrutiny_day? or self.is_lords_scrutiny_day?
  
      # ... we set the is either house scrutiny day boolean to true.
      is_either_house_scrutiny_day = true
    end
    
    # We return the is either house scrutiny day boolean.
    is_either_house_scrutiny_day
  end

  # ## A set of methods to determine the relationship of a day to its containing or preceding session.
  
  # ### We want to determine if this is the final day of a session.
  def is_final_day_of_session?
  
    #  We set the is final day of session boolean to false.
    is_final_day_of_session = false
    
    # We attempt to find a session ending on this date.
    session = Session.all.where( "end_date = ?", self ).first
    
    # If we find a session ending on this data ...
    if session
      
      # ... we set the is final day of session boolean to true.
      is_final_day_of_session = true
    end
    
    # We return the is final day of session boolean.
    is_final_day_of_session
  end
  
  # ### We want to find the session immediately preceding this day.
  def preceding_session
  
    # We attempt to find the first session starting before this day.
    Session.all.where( "start_date < ?", self ).order( "start_date DESC" ).first
  end
  
  # ### We want to find the session immediately following this day.
  # This method is used to determine which session papers laid in prorogation are recorded in.
  def following_session
  
    # We attempt to find the next session starting after this day.
    Session.all.where( "start_date > ?", self ).order( "start_date" ).first
  end
  
  # ## A set of methods to find the first following and first preceding joint sitting days.
  
  # ### We attempt to find the first following joint sitting day.
  # This method is used in the forwards calculations for a Proposed Negative Statutory Instrument.
  # Even if a PNSI is laid on a joint sitting day, the clock does not start until the next joint sitting day.
  def first_joint_parliamentary_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... we cannot find a following joint sitting day, so we stop looking.
      return nil

    # Otherwise, if this is a day on which the calendar is populated ...
    else

      # ... if this is not a joint sitting day ...
      unless self.is_joint_parliamentary_sitting_day?

        # ... we go to the next day and check that.
        self.next_day.first_joint_parliamentary_sitting_day

      # Otherwise, if this is a joint sitting day ...
      else

        # ... we return this day as the first following joint sitting day.
        self
      end
    end
  end
  
  # ### We want to find the first preceding joint sitting day.
  # This method is used in the backwards calculations for a Proposed Negative Statutory Instrument.
  # Even if a PNSI is laid on a joint sitting day, the clock does not start until the next joint sitting day.
  def last_joint_parliamentary_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... we cannot find a preceding joint sitting day, so we stop looking.
      return nil

    # Otherwise, if this is a day on which the calendar is populated ...
    else

      # ... if this is not a joint sitting day ...
      unless self.is_joint_parliamentary_sitting_day?

        # ... we go to the previous day and check that.
        self.prev_day.last_joint_parliamentary_sitting_day

      # Otherwise, if this is a joint sitting day ...
      else

        # ... we return this day as the first preceding joint sitting day.
        self
      end
    end
  end
  
  # ## A set of methods to apply labels to a day in the calendar views.
  
  # ### A method to generate a label for the type of a day in the Commons in a session.
  def commons_day_type
  
    # If the day is a parliamentary sitting day in the Commons ...
    if self.is_commons_parliamentary_sitting_day?
    
      # ... we set the day type label to 'Sitting day'.
      day_type = 'Sitting day'
      
    # Otherwise, if the day is a continuation sitting day in the Commons ...
    elsif self.is_commons_continuation_sitting_day?
    
      # ... we set the day type label to 'Continuation sitting day'.
      day_type = "Continuation sitting day"
      
    # Otherwise, if the day is a virtual sitting day in the Commons ...
    elsif self.is_commons_virtual_sitting_day?
    
      # ... we set the day type label to 'Virtual sitting day'.
      day_type = 'Virtual sitting day'
      
    # Otherwise, if the day is a adjournment day in the Commons ...
    elsif self.is_commons_adjournment_day?
    
      # ... we want to display if the adjournment day forms part of a named recess ...
      # ... so we call the Commons adjournment day label method.
      day_type = self.commons_adjournment_day_label
      
    # Otherwise, if the day is in a session but has no defined type ...
    elsif self.session
    
      # ... we set the day type label to 'Session day of unknown type'.
      day_type = 'Session day of unknown type'
      
    # Otherwise, if the day is a prorogation day ...
    elsif self.is_prorogation_day?
    
      # ... we set the day type label to 'Prorogation'.
      day_type = 'Prorogation'
      
    # Otherwise, if the day is a dissolution day ...
    elsif self.is_dissolution_day?
    
      # ... we set the day type label to 'Dissolution'.
      day_type = 'Dissolution'
    end
    
    # We return the day type label.
    day_type
  end
  
  # ### A method to generate a label for the type of a day in the Lords in a session.
  def lords_day_type
  
    # If the day is a parliamentary sitting day in the Lords ...
    if self.is_lords_parliamentary_sitting_day?
    
      # ... we set the day type label to 'Sitting day'.
      day_type = 'Sitting day'
      
    # Otherwise, if the day is a continuation sitting day in the Lords ...
    elsif self.is_lords_continuation_sitting_day?
    
      # ... we set the day type label to 'Continuation sitting day'.
      day_type = "Continuation sitting day"
      
    # Otherwise, if the day is a virtual sitting day in the Lords ...
    elsif self.is_lords_virtual_sitting_day?
    
      # ... we set the day type label to 'Virtual sitting day'.
      day_type = 'Virtual sitting day'
      
    # Otherwise, if the day is a adjournment day in the Lords ...
    elsif self.is_lords_adjournment_day?
    
      # ... we want to display if the adjournment day forms part of a named recess ...
      # ... so we call the Lords adjournment day label method.
      day_type = self.lords_adjournment_day_label
      
    # Otherwise, if the day is in a session but has no defined type ...
    elsif self.session
    
      # ... we set the day type label to 'Session day of unknown type'.
      day_type = 'Session day of unknown type'
      
    # Otherwise, if the day is a prorogation day ...
    elsif self.is_prorogation_day?
    
      # ... we set the day type label to 'Prorogation'.
      day_type = 'Prorogation'
      
    # Otherwise, if the day is a dissolution day ...
    elsif self.is_dissolution_day?
    
      # ... we set the day type label to 'Dissolution'.
      day_type = 'Dissolution'
    end
    
    # We return the day type label.
    day_type
  end
  
  # ## A set of methods to decorate a day label for an adjournment day with the name of a recess where applicable.
  
  # ### A method to label a Commons adjournment day, with the name of a recess if applicable.
  def commons_adjournment_day_label
  
    # We set the day type label to 'Adjournment day'
    day_type = 'Adjournment day'

    # We attempt to find a recess on this date, in this House.
    recess_date = RecessDate
      .all
      .where( "start_date <= ?", self )
      .where( "end_date >= ?", self )
      .where( house_id: 1 ) # 1 being the ID of the House of Commons.
      .first

    # If we find a recess date on this day, in this House ...
    if recess_date

      # ... we append the description of the recess date to the day type label.
      day_type += ' (' + recess_date.description + ')'
    end
    
    # We return the day type label.
    day_type
  end
  
  # ### A method to label a Lords adjournment day, with the name of a recess if applicable.
  def lords_adjournment_day_label
  
    # We set the day type label to 'Adjournment day'
    day_type = 'Adjournment day'

    # We attempt to find a recess on this date, in this House.
    recess_date = RecessDate
      .all
      .where( "start_date <= ?", self )
      .where( "end_date >= ?", self )
      .where( house_id: 2 ) # 2 being the ID of the House of Lords.
      .first

    # If we find a recess date on this day, in this House ...
    if recess_date

      # ... we append the description of the recess date to the day type label.
      day_type += ' (' + recess_date.description + ')'
    end
    
    # We return the day type label.
    day_type
  end
  
  # ## A set of methods to generate a label for whether this day counts as a scrutiny day in a House, or not.
  
  # ## A method to generate a label for whether this day counts as a scrutiny day in the Commons, or not.
  def is_commons_scrutiny_day_label
  
    # If this is a scrutiny day in the Commons ...
    if self.is_commons_scrutiny_day?
    
      # ... we set the label to 'True'.
      label = 'True'
      
    # Otherwise, if this is not a scrutiny day in the Commons ...
    else
    
      # ... we set the label to 'False'.
      label = 'False'
    end
    
    # We return the label.
    label
  end
  
  # ## A method to generate a label for whether this day counts as a scrutiny day in the Lords, or not.
  def is_lords_scrutiny_day_label
  
    # If this is a scrutiny day in the Lords ...
    if self.is_lords_scrutiny_day?
    
      # ... we set the label to 'True'.
      label = 'True'
      
    # Otherwise, if this is not a scrutiny day in the Lords ...
    else
    
      # ... we set the label to 'False'.
      label = 'False'
    end
    
    # We return the label.
    label
  end
end

# We include these methods in the Ruby Data class.
Date.include( DateMonkeyPatch )