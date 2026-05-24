# # A monkey patched Ruby date class to handle UK Parliament specific day types.
module DateMonkeyPatchDeprecated

  # ######### DEPRECATED METHODS ###############

  # we've changed actual sitting day to calendar
  # parliamentary sitting day remains parliamentary sitting day.

  #### We want to check if this is an actual sitting day in the Commons.

  # We use a naive definition of a sitting day: this includes a calendar day when the Commons sits, together with following calendar days if the Commons sat through the night.

  # For example: if the Commons sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as actual sitting days.

  # If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.

  def is_commons_actual_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end



  # #### We want to check if this is an actual sitting day in the Lords.

  # We use a naive definition of a sitting day: this includes a calendar day when the Lords sits, together with following calendar days if the Lords sat through the night.

  # For example: if the Lords sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as actual sitting days.

  # If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.

  def is_lords_actual_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end


  # ### We want to check if this is an adjournment day in either House.
  def is_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end

  # ### We want to check if this is an actual sitting day in *either* House.
  def is_either_house_actual_sitting_day?
    self.is_commons_actual_sitting_day? or self.is_lords_actual_sitting_day?
  end

  #### We want to determine if this is an actual sitting day in *both* Houses.

  def is_joint_actual_sitting_day?
    self.is_commons_actual_sitting_day? and self.is_lords_actual_sitting_day?
  end

  ### A set of methods to find the first day of a given type.

  #### We want to find the first scrutiny day in *either* House.

  # This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during a non-sitting period of more than four days, or during a period in which Parliament is prorogued. In such cases, the clock starts from the first actual sitting day in either House following the laying.

  # This method is used for bicameral negative SIs - and bicameral made affirmatives where the enabling legislation specifies that either House can be sitting.

  def first_scrutiny_day_in_either_house

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first scrutiny day so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not a scrutiny day in *either* House ...
      unless self.is_either_house_scrutiny_day?

        # ... then go to the next day and check that.
        self.next_day.first_scrutiny_day_in_either_house

      # ... then if this is a scrutiny day in either House ...
      else

        # ... then return this day as the first scrutiny day in either House.
        self
      end
    end
  end

  #### We want to find the first scrutiny day in *both* Houses.

  # This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first actual sitting day in both Houses following the laying.

  # This method is used for bicameral made affirmatives where the enabling legislation specifies that both Houses must be sitting.

  def first_joint_scrutiny_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first scrutiny day so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not a scrutiny day in both Houses ...
      unless self.is_joint_scrutiny_day?

        # ... then go to the next day and check that.
        self.next_day.first_joint_scrutiny_day

      # ... then if this is a scrutiny day in both Houses ...
      else

        # ... then return this day as the first scrutiny day in both Houses.
        self
      end
    end
  end

  #### We want to find the first scrutiny day in the Commons.

  # This method is used when a Statutory Instrument is laid outside of a scrutiny period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first actual sitting day in the Commons following the laying.

  # This method is used for negative or made affirmative SIs - laid in the Commons and not laid in the Lords.

  def first_commons_scrutiny_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first Commons scrutiny day so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not a scrutiny day in the Commons ...
      unless self.is_commons_scrutiny_day?

        # ... then go to the next day and check that.
        self.next_day.first_commons_scrutiny_day

      # ... then if this is a scrutiny day in the Commons ...
      else

        # ... then return this day as the first scrutiny day in the Commons.
        self
      end
    end
  end

  #### We want to find the first parliamentary sitting day in both Houses.

  # This method is used when a Proposed Negative Statutory Instrument is laid.

  # Even if a PNSI is laid on a joint parliamentary sitting day, the clock does not start until the next joint parliamentary sitting day.

  def first_joint_parliamentary_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first parliamentary sitting day in both Houses so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not a parliamentary sitting day in both Houses ...
      unless self.is_joint_parliamentary_sitting_day?

        # ... then go to the next day and check that.
        self.next_day.first_joint_parliamentary_sitting_day

      # ... then if this is a parliamentary sitting day in both Houses ...
      else

        # ... then return this day as the first parliamentary sitting day in both Houses.
        self
      end
    end
  end

  #### We want to find the last preceding parliamentary sitting day in both Houses.

  # This method is used when a Proposed Negative Statutory Instrument is laid.

  # Even if a PNSI is laid on a joint parliamentary sitting day, the clock does not start until the next joint parliamentary sitting day.

  def last_joint_parliamentary_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first parliamentary sitting day in both Houses so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not a parliamentary sitting day in both Houses ...
      unless self.is_joint_parliamentary_sitting_day?

        # ... then go to the previous day and check that.
        self.prev_day.last_joint_parliamentary_sitting_day

      # ... then if this is a parliamentary sitting day in both Houses ...
      else

        # ... then return this day as the first parliamentary sitting day in both Houses.
        self
      end
    end
  end

  #### We want to find the first actual sitting day in both Houses.

  # This method is used to calculate periods A and B for treaties.

  # Even if a treaty is laid or a ministerial statement is made on a joint actual sitting day, the clock does not start until the next joint actual sitting day.

  def first_joint_actual_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first actual sitting day in both Houses so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not an actual sitting day in both Houses ...
      unless self.is_joint_actual_sitting_day?

        # ... then go to the next day and check that.
        self.next_day.first_joint_actual_sitting_day

      # ... then if this is an actual sitting day in both Houses ...
      else

        # ... then return this day as the first actual sitting day in both Houses.
        self
      end
    end
  end

  #### We want to find the first actual sitting day in the House of Commons.

  # This method is used by the House of Commons only sitting day calculation.

  # Even if an instrument is laid on a House of Commons actual sitting day, the clock does not start until the next House of Commons actual sitting day.

  def first_commons_actual_sitting_day

    # If this is a day on which the calendar is not yet populated ...
    if self.is_calendar_not_populated?

      # ... then we cannot find a first actual sitting day in the House of Commons so we stop looking.
      return nil

    # If this is a day on which the calendar is populated ...
    else

      # ... then if this is not an actual sitting day in the House of Commons ...
      unless self.is_commons_actual_sitting_day?

        # ... then go to the next day and check that.
        self.next_day.first_commons_actual_sitting_day

      # ... then if this is an actual sitting day in the House of Commons ...
      else

        # ... then return this day as the first actual sitting day in the House of Commons.
        self
      end
    end
  end

  def is_commons_calendar_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end

  def is_lords_calendar_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
end

Date.include(DateMonkeyPatchDeprecated)