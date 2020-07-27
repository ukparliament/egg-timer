class Date
  
  # A monkey patched Ruby date class to handle UK Parliament specific day types.
  
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
  
  
  
  # edited to here
  
  
  
  
  
  # Checks if this is a praying adjournment day in the Commons
  # Praying adjournment days are during short periods of adjournment
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  # In all cases we know of, it is a period of not more than 4 days adjourned
  def is_commons_praying_adjournment_day?( maximum_day_count )
    
    # Check if this is an adjournnment day
    if self.is_commons_adjournment_day? or self.is_commons_virtual_sitting_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day or a virtual sitting day in the Commons
        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
          
          # Add one to the adjournment day count
          adjournment_day_count +=1
        
        # If it's not an adjournment day...
        else  
          
          # ...stop cycling forward
          break
        end
      end
      
      # Cycle through the preceding days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go back one day
        date = date.prev_day
        
        # If this is an adjournment day or a virtual sitting day in the Commons
        if date.is_commons_adjournment_day? or date.is_commons_virtual_sitting_day?
          
          # Add one to the adjournment day count
          adjournment_day_count +=1
        
        # If it's not an adjournment day...
        else  
          
          # ...stop cycling backward.
          break
        end
      end

      # If there's more than the maximum number of adjournment days passed in...
      if adjournment_day_count > maximum_day_count
      
        # ...this is not a short adjournment and does not count on the clock
        is_commons_short_adjournment = false
      
      # If this is 4 or more days adjournment...
      else
      
        # ....this is a short adjournnment and does count on the clock
        is_commons_short_adjournment = true
      end
      is_commons_short_adjournment
    end
  end
  
  # Checks if this is a commons praying day
  # A day is a Commons praying day if it's either a Commons praying sitting day or a Commons praying adjournment day
  # We define a Commons praying adjournment day as being one day in a series of not more than 4 days for which the Commons is adjourned
  def is_commons_praying_day?
    self.is_commons_praying_sitting_day? or self.is_commons_praying_adjournment_day?( 4 )
  end
  
  # Checks if this is a praying adjournment day in the Lords
  # Praying adjournment days are during short periods of adjournment
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  # In all cases we know of, it is a period of not more than 4 days adjourned
  def is_lords_praying_adjournment_day?( maximum_day_count )
    
    # Check if this is an adjournnment day or a virtual sitting day
    if self.is_lords_adjournment_day? or self.is_lords_virtual_sitting_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day or a virtual sitting day in the Lords
        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
          
          # Add one to the adjournment day count
          adjournment_day_count +=1
        
        # If it's not an adjournment day...
        else  
          
          # ...stop cycling forward
          break
        end
      end
      
      # Cycle through the preceding days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go back one day
        date = date.prev_day
        
        # If this is an adjournment day or a virtual sitting day in the Lords
        if date.is_lords_adjournment_day? or date.is_lords_virtual_sitting_day?
          
          # Add one to the adjournment day count
          adjournment_day_count +=1
        
        # If it's not an adjournment day...
        else  
          
          # ...stop cycling backward.
          break
        end
      end

      # If there's more than the maximum number of adjournment days passed in...
      if adjournment_day_count > maximum_day_count
      
        # ...this is not a short adjournment and does not count on the clock
        is_lords_short_adjournment = false
      
      # If this is 4 or more days adjournment...
      else
      
        # ....this is a short adjournnment and does count on the clock
        is_lords_short_adjournment = true
      end
      is_lords_short_adjournment
    end
  end
  
  # Checks if this is a lords praying day
  # A day is a Lords praying day if it's either a Lords praying sitting day or a Lords praying adjournment day
  # We define a Lords praying adjournment day as being one day in a series of not more than 4 days for which the Lords is adjourned
  def is_lords_praying_day?
    self.is_lords_praying_sitting_day? or self.is_lords_praying_adjournment_day?( 4 )
  end
  
  # Checks if this is a praying day in either House
  def is_either_house_praying_day?
    self.is_commons_praying_day? or self.is_lords_praying_day?
  end
  
  # Checks if this is a praying day in both Houses
  def is_joint_praying_day?
    self.is_commons_praying_day? and self.is_lords_praying_day?
  end
  
  # END OF METHODS TO WORK OUT WHAT TYPE OF DAY THIS IS
  
  
  
  
  
  
  # Cycles to get first praying day in either House
  # Used for negative SIs and some made affirmatives where the clock starts ticking from the first sitting day if the instrument is laid during an long adjournment (> 4 days)
  def first_praying_day_in_either_house
    
    # If this is an as yet unannounced day...
    if self.is_calendar_not_populated?
      
      # ...give up finding a first praying day in either House
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a praying day in either House, go check the next one
      unless self.is_either_house_praying_day?
        self.next_day.first_praying_day_in_either_house
        
      # ..if this is a praying day in either House, return it
      else
        self
      end
    end
  end
  
  # cycles to get first joint praying day
  # used for made affirmatives when both Houses must be sitting
  def first_joint_praying_day
    
    # If this is an as yet unannounced day...
    if self.is_calendar_not_populated?
      
      # ...give up finding a first joint sitting day
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a joint praying day, go check the next one
      unless self.is_joint_praying_day?
        self.next_day.first_joint_praying_day
        
      # ..if this is a joint sitting day, return it
      else
        self
      end
    end
  end
  
  # Cycles to get first Commons praying day
  # Used for negative SIs and some made affirmatives where the clock starts ticking from the first sitting day if the instrument is laid during an long adjournment (> 4 days)
  def first_commons_praying_day
    
    # If this is an as yet unannounced day...
    if self.is_calendar_not_populated?
      
      # ...give up finding a first Commons praying day
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a praying day in either House, go check the next one
      unless self.is_commons_praying_day?
        self.next_day.first_commons_praying_day
        
      # ..if this is a praying day in either House, return it
      else
        self
      end
    end
  end
  
  # cycles to get first joint sitting day
  # used for pnsis where the clock starts ticking from the first joint sitting day
  # pnsis use parliamentary sitting days
  def first_joint_parliamentary_sitting_day
    
    # If this is an as yet unannounced day...
    if self.is_calendar_not_populated?
      
      # ...give up finding a first joint sitting day
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a joint sitting day, go check the next one
      unless self.is_joint_parliamentary_sitting_day?
        self.next_day.first_joint_parliamentary_sitting_day
        
      # ..if this is a joint sitting day, return it
      else
        self
      end
    end
  end
  
  # cycles to get first House of Commons parliamentary sitting day
  # Used for treaty period B
  def first_commons_parliamentary_sitting_day
    
    # If this is an as yet unannounced day...
    if self.is_calendar_not_populated?
      
      # ...give up finding a first Commons sitting day
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a House of Commons parliamentary sitting day, go check the next one
      unless self.is_commons_parliamentary_sitting_day?
        self.next_day.first_commons_parliamentary_sitting_day
        
      # ..if this is a House of Commons parliamentary sitting day, return it
      else
        self
      end
    end
  end
  
  # Generate label for the day type in the Commons in a session
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
  
  # Generate label for the day type in the Lords in a session
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
  
  # Generates a label to say whether it's a praying day in the Commons. Or not
  def is_commons_praying_day_label
    if self.is_commons_praying_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
  
  # Generates a label to say whether it's a praying day in the Lords. Or not
  def is_lords_praying_day_label
    if self.is_lords_praying_day?
      label = 'True'
    else
      label = 'False'
    end
    label
  end
end