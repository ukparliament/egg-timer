class Date
  
  ## A monkey patched Ruby date class to handle UK Parliament specific day types.
  
  # A set of methods to work out the type of a given day.
  
  # We want to check if this is a praying sitting day in the Commons.
  # We use a naive definition of a sitting day: this includes a calendar day when the Commons sits, together with following calendar days if the Commons sat through the night.
  # For example: if the Commons sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as praying sitting days. 
  # If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.
  def is_commons_praying_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # We want to check if this is a praying sitting day in the Lords.
  # We use a naive definition of a sitting day: this includes a calendar day when the Lords sits, together with following calendar days if the Lords sat through the night.
  # For example: if the Lords sat on a Tuesday and continued to sit overnight into Wednesday, both Tuesday and Wednesday would count as praying sitting days. 
  # If the Tuesday sitting lasted long enough to overlap the starting time of the Wednesday sitting, the Tuesday would be a parliamentary sitting day, but the Wednesday would not.
  def is_lords_praying_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # We want to check if this is a parliamentary sitting day in the Commons. 
  # We use a more strict definition of a sitting day. We don’t include dates for which the Commons continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.
  def is_commons_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
  end
  
  # We want to check if this is a parliamentary sitting day in the Lords. 
  # We use a more strict definition of a sitting day. We don’t include dates for which the Lords continued sitting from a previous day, where the preceding day’s sitting overlapped with the next day’s programmed sitting.
  def is_lords_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
  end
  
  # We want to check if this is a virtual sitting day in the Commons: this is a day where all Members of the House sit ‘digitally’, rather than physically.
  # A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.
  # As of the end of June 2020, the Commons has had no virtual sitting days.
  def is_commons_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # We want to check if this is a virtual sitting day in the Lords: this is a day where all Members of the House sit ‘digitally’, rather than physically.
  # A virtual sitting may continue over more than one calendar day. We count any continuation, where the preceding day’s sitting overlapped with the next day’s programmed sitting, as also being a virtual sitting day.
  def is_lords_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # We want to check if this is a praying sitting day in either House.
  def is_either_house_praying_sitting_day?
    self.is_commons_praying_sitting_day? or self.is_lords_praying_sitting_day?
  end
  
  # We want to check if this is a praying sitting day in both Houses.
  def is_joint_praying_sitting_day?
    self.is_commons_praying_sitting_day? and self.is_lords_praying_sitting_day?
  end
  
  # We want to check if this is a parliamentary sitting day in either House.
  def is_either_house_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? or self.is_lords_parliamentary_sitting_day?
  end
  
  # We want to check if this is a parliamentary sitting day in both Houses.
  def is_joint_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
  end
  
  # We want to check if this is an adjournment day in either House.
  def is_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end
  
  # We want to check if this is an adjournment day in the Commons.
  def is_commons_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 1 ).first
  end
  
  # We want to check if this is an adjournment day in the Lords.
  def is_lords_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).where( house_id: 2 ).first
  end
  
  # We want to check if Parliament is prorogued on this day.
  def is_prorogation_day?
    ProrogationDay.all.where( 'date = ?',  self ).first
  end
  
  # We want to check if Parliament is dissolved on this day.
  def is_dissolution_day?
    DissolutionDay.all.where( 'date = ?',  self ).first
  end
  
  # We want to check if this is a day for which we have something in the calendar.
  # That might be a parliamentary sitting day, a praying sitting day, a virtual sitting day, an adjournment day, a day within prorogation or a day within dissolution.
  def is_calendar_populated?
    self.is_commons_praying_sitting_day? or self.is_lords_praying_sitting_day? or self.is_commons_virtual_sitting_day? or self.is_lords_virtual_sitting_day? or self.is_adjournment_day? or self.is_prorogation_day? or self.is_dissolution_day?
  end
  
  # We want to check if this is a day for which we do not have anything in the calendar.
  # We use this to check if we've "run out of calendar" so we don't keep cycling into future days and loop infinitely.
  # This is our event horizon.
  def is_calendar_not_populated?
    !self.is_calendar_populated?
  end
  
  # We want to check if this is a praying adjournment day in the Commons.
  # During a short adjournment, adjournment days are praying days.
  # This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.
  # In all known cases “short” is defined as not more than four days.
  # For the purposes of calculating praying days, virtual sitting days count as adjournment days.
  def is_commons_praying_adjournment_day?( maximum_day_count )
    
    # We want to check if this is a Commons adjournnment day or a Commons virtual sitting day.
    if self.is_commons_adjournment_day? or self.is_commons_virtual_sitting_day?
      
      # Having found that this is a Commons adjournnment day or a Commons virtual sitting day, we start the adjournment day count at 1.
      adjournment_day_count = 1
      
      # We want to cycle through the following days until we reach the maximum day count passed into this function.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day.
        date = date.next_day
        
        # If this is a Commons adjournnment day or a Commons virtual sitting day...
        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
          
          # ...add one to the adjournment day count.
          adjournment_day_count +=1
        
        # If this is not a Commons adjournnment day or a Commons virtual sitting day...
        else
          
          # ...stop cycling through following days.
          break
        end
      end
      
      # We want to cycle through the preceding days until we reach the maximum day count passed into this function.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go back one day.
        date = date.prev_day
        
        # If this is a Commons adjournnment day or a Commons virtual sitting day...
        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
          
          # ...add one to the adjournment day count.
          adjournment_day_count +=1
        
        # If this is not a Commons adjournnment day or a Commons virtual sitting day...
        else  
          
          # ...stop cycling through preceding days.
          break
        end
      end
      
      # If the total number of continuous adjournment days is more than the maximum day count...
      if adjournment_day_count > maximum_day_count
      
        # ...then this day is not part of a short adjournment and so does not count as a praying day.
        is_commons_short_adjournment = false
      
      # If the total number of continuous adjournment days is less than or the same as the maximum day count...
      else
      
        # ....then this day is part of a short adjournment and so does count as a praying day.
        is_commons_short_adjournment = true
      end
      
      # Returns if this day is a part of a Commons short adjournment
      is_commons_short_adjournment
    end
  end
  
  # We want to check if this is a praying day in the Commons.
  # A praying day in the Commons is either a praying sitting day in the Commons, or a praying adjournment day in the Commons.
  # We pass '4' as the maximum day count to the adjournment day calculation, because praying adjournment days are days within a series of not more than four adjournment days.
  def is_commons_praying_day?
    self.is_commons_praying_sitting_day? or self.is_commons_praying_adjournment_day?( 4 )
  end
  
  # We want to check if this is a praying adjournment day in the Lords.
  # During a short adjournment, adjournment days are praying days.
  # This method allows the definition of a “short” adjournment to be adjusted by passing in a maximum day count.
  # In all known cases “short” is defined as not more than four days.
  # For the purposes of calculating praying days, virtual sitting days count as adjournment days.
  def is_lords_praying_adjournment_day?( maximum_day_count )
    
    # We want to check if this is a Lords adjournnment day or a Lords virtual sitting day.
    if self.is_lords_adjournment_day? or self.is_lords_virtual_sitting_day?
      
      # Having found that this is a Lords adjournnment day or a Lords virtual sitting day, we start the adjournment day count at 1.
      adjournment_day_count = 1
      
      # We want to cycle through the following days until we reach the maximum day count passed into this function.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day.
        date = date.next_day
        
        # If this is a Lords adjournnment day or a Lords virtual sitting day...
        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
          
          # ...add one to the adjournment day count.
          adjournment_day_count +=1
        
        # If this is not a Lords adjournnment day or a Lords virtual sitting day...
        else
          
          # ...stop cycling through following days.
          break
        end
      end
      
      # We want to cycle through the preceding days until we reach the maximum day count passed into this function.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go back one day.
        date = date.prev_day
        
        # If this is a Lords adjournnment day or a Lords virtual sitting day...
        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
          
          # ...add one to the adjournment day count.
          adjournment_day_count +=1
        
        # If this is not a Lords adjournnment day or a Lords virtual sitting day...
        else  
          
          # ...stop cycling through preceding days.
          break
        end
      end
      
      # If the total number of continuous adjournment days is more than the maximum day count...
      if adjournment_day_count > maximum_day_count
      
        # ...then this day is not part of a short adjournment and so does not count as a praying day.
        is_lords_short_adjournment = false
      
      # If the total number of continuous adjournment days is less than or the same as the maximum day count...
      else
      
        # ....then this day is part of a short adjournment and so does count as a praying day.
        is_lords_short_adjournment = true
      end
      
      # Returns if this day is a part of a Lords short adjournment
      is_lords_short_adjournment
    end
  end
  
  # We want to check if this is a praying day in the Lords.
  # A praying day in the Lords is either a praying sitting day in the Lords, or a praying adjournment day in the Lords.
  # We pass '4' as the maximum day count to the adjournment day calculation, because praying adjournment days are days within a series of not more than four adjournment days.
  def is_lords_praying_day?
    self.is_lords_praying_sitting_day? or self.is_lords_praying_adjournment_day?( 4 )
  end
  
  # We want to check if this is a praying day in either House.
  def is_either_house_praying_day?
    self.is_commons_praying_day? or self.is_lords_praying_day?
  end
  
  # We want to check if this is a praying day in both Houses.
  def is_joint_praying_day?
    self.is_commons_praying_day? and self.is_lords_praying_day?
  end
  
  # End of set of methods to work out the type of a given day.
  

  
  # A set of methods to find the first day of a given type.
  
  # We want to find the first praying day in either House.
  # This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. In such cases, the clock starts from the first praying sitting day in either House following the laying.
  # This method is used for bicameral negative SIs - and bicameral made affirmatives where the enabling legislation specifies that either House can be sitting.
  def first_praying_day_in_either_house
    
    # If this is a day on which the calendar is not yet populated...
    if self.is_calendar_not_populated?
      
      # ...then we cannot find a first praying day so we stop looking.
      return nil
    
    # If this is a day on which the calendar is populated...
    else
      
      # ...then if this is not a praying day in either House...
      unless self.is_either_house_praying_day?
        
        # ...then go to the next day and check that.
        self.next_day.first_praying_day_in_either_house
        
      # ...then if this is a praying day in either House...
      else
        
        # ...then return this day as the first praying day in either House.
        self
      end
    end
  end
  
  # We want to find the first praying day in both Houses.
  # This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first praying sitting day in both Houses following the laying.
  # This method is used for bicameral made affirmatives where the enabling legislation specifies that both Houses must be sitting.
  def first_joint_praying_day
    
    # If this is a day on which the calendar is not yet populated...
    if self.is_calendar_not_populated?
      
      # ...then we cannot find a first praying day so we stop looking.
      return nil
    
    # If this is a day on which the calendar is populated...
    else
      
      # ...then if this is not a praying day in both Houses...
      unless self.is_joint_praying_day?
        
        # ...then go to the next day and check that.
        self.next_day.first_joint_praying_day
        
      # ...then if this is a praying day in both Houses...
      else
        
        # ...then return this day as the first praying day in both Houses.
        self
      end
    end
  end
  
  # We want to find the first praying day in the Commons.
  # This method is used when a Statutory Instrument is not laid in a praying period, that is: during an adjournment of more than four days, or during a period in which Parliament is prorogued. The clock starts from the first praying sitting day in the Commons following the laying.
  # This method is used for negative or made affirmative SIs - laid in the Commons and not laid in the Lords.
  def first_commons_praying_day
    
    # If this is a day on which the calendar is not yet populated...
    if self.is_calendar_not_populated?
      
      # ...then we cannot find a first Commons praying day so we stop looking.
      return nil
    
    # If this is a day on which the calendar is populated...
    else
      
      # ...then if this is not a praying day in the Commons...
      unless self.is_commons_praying_day?
        
        # ...then go to the next day and check that.
        self.next_day.first_commons_praying_day
        
      # ...then if this is a praying day in the Commons...
      else
        
        # ...then return this day as the first praying day in the Commons.
        self
      end
    end
  end
  
  # We want to find the first parliamentary sitting day in both Houses.
  # This method is used when a Proposed Negative Statutory Instrument is laid.
  # Even if a PNSI is laid on a joint parliamentary sitting day, the clock does not start until the next joint parliamentary sitting day.
  def first_joint_parliamentary_sitting_day
    
    # If this is a day on which the calendar is not yet populated...
    if self.is_calendar_not_populated?
      
      # ...then we cannot find a first parliamentary sitting day in both Houses so we stop looking.
      return nil
    
    # If this is a day on which the calendar is populated...
    else
      
      # ...then if this is not a parliamentary sitting day in both Houses...
      unless self.is_joint_parliamentary_sitting_day?
        
        # ...then go to the next day and check that.
        self.next_day.first_joint_parliamentary_sitting_day
        
      # ...then if this is a parliamentary sitting day in both Houses...
      else
        
        # ...then return this day as the first parliamentary sitting day in both Houses.
        self
      end
    end
  end
  
  # We want to find the first parliamentary sitting day in the Commons.
  # This method is used when a motion to not ratify a treaty in either House is approved - and the Government make a statement that the treaty should nonetheless be ratified, triggering treaty scrutiny period B.
  # Treaty scrutiny period B starts on the first Commons parliamentary sitting day following the date of the Government statement.
  def first_commons_parliamentary_sitting_day
    
    # If this is a day on which the calendar is not yet populated...
    if self.is_calendar_not_populated?
      
      # ...then we cannot find a first parliamentary sitting day in the Commons so we stop looking.
      return nil
    
    # If this is a day on which the calendar is populated...
    else
      
      # ...then if this is not a parliamentary sitting day in the Commons...
      unless self.is_commons_parliamentary_sitting_day?
        
        # ...then go to the next day and check that.
        self.next_day.first_commons_parliamentary_sitting_day
        
      # ...then if this is a parliamentary sitting day in the Commons...
      else
        
        # ...then return this day as the first parliamentary sitting day in the Commons.
        self
      end
    end
  end
  
  # End of set of methods to find the first day of a given type.
  
  
  
  
  
  
  
  
  
  
  # Generate label for the day type in the Commons in a session.
  def commons_day_type
    if self.is_commons_parliamentary_sitting_day?
      day_type = 'Sitting day'
    elsif self.is_commons_virtual_sitting_day?
      day_type = 'Virtual sitting day'
    elsif self.is_commons_praying_sitting_day?
      day_type = "Sitting praying day"
    elsif self.is_commons_praying_adjournment_day?( 4 )
      day_type = 'Praying adjournment day'
    elsif self.is_commons_adjournment_day?
      day_type = 'Adjournment day'
    end
    day_type
  end
  
  # Generate label for the day type in the Lords in a session.
  def lords_day_type
    if self.is_lords_parliamentary_sitting_day?
      day_type = 'Sitting day'
    elsif self.is_lords_virtual_sitting_day?
      day_type = 'Virtual sitting day'
    elsif self.is_lords_praying_sitting_day?
      day_type = "Sitting praying day"
    elsif self.is_lords_praying_adjournment_day?( 4 )
      day_type = 'Praying adjournment day'
    elsif self.is_lords_adjournment_day?
      day_type = 'Adjournment day'
    end
    day_type
  end
  
  # Generate a label to say whether it's a praying day in the Commons or not.
  def is_commons_praying_day_label
    if self.is_commons_praying_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
  
  # Generate a label to say whether it's a praying day in the Lords or not.
  def is_lords_praying_day_label
    if self.is_lords_praying_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
end