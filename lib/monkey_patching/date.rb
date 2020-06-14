class Date
  
  # METHODS TO WORK OUT WHAT TYPE OF DAY THIS IS
  
  # check if this is a praying sitting day in the commons
  # naive version of "sitting day". this is really did the commons sit on this calendar day
  # it might be that this calendar day is a continuation of a previous day's sitting
  # so in a parliament sense it did not "sit" on this day
  def is_commons_praying_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # check if this is a praying sitting day in the lords
  # naive version of "sitting day". this is really did the commons sit on this calendar day
  # it might be that this calendar day is a continuation of a previous day's sitting
  # so in a parliament sense it did not "sit" on this day
  def is_lords_praying_sitting_day?
    SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # check if this was a parliamentary sitting day for the commons
  # does not include dates for which the commons continued sitting from a previous day
  def is_commons_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
  end
  
  # check if this was a parliamentary sitting day for the lords
  # does not include dates for which the lords continued sitting from a previous day
  def is_lords_parliamentary_sitting_day?
    SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
  end
  
  # check if the commons is sitting virtually on a day
  # naive. this is really did the commons sit virtually on this calendar day
  # it might be that this calendar day is a continuation of a previous day's virtual sitting
  # so in a parliament sense it did not "sit" on this day
  def is_commons_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
  end
  
  # check if the lords is sitting virtually on a day
  # naive. this is really did the lords sit virtually on this calendar day
  # it might be that this calendar day is a continuation of a previous day's virtual sitting
  # so in a parliament sense it did not "sit" on this day
  def is_lords_virtual_sitting_day?
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # checks if either House is sitting on a day
  # naive. it might be that this calendar day is a continuation of a previous day's sitting for one or both Houses
  # so in a parliament sense that House did not "sit" on this day
  def is_either_house_praying_sitting_day?
    self.is_commons_praying_sitting_day? or self.is_lords_praying_sitting_day?
  end
  
  # checks if both Houses are sitting on a day
  # naive. it might be that this calendar day is a continuation of a previous day's sitting for one or both Houses
  # so in a parliament sense that House did not "sit" on this day
  def is_joint_praying_sitting_day?
    self.is_commons_praying_sitting_day? and self.is_lords_praying_sitting_day?
  end
  
  # checks if this is a parliamentary sitting day for one or both Houses
  # does not include days continued from previous sitting days
  def is_either_house_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? or self.is_lords_parliamentary_sitting_day?
  end
  
  # checks if this is a parliamentary sitting day for both Houses
  # does not include days continued from previous sitting days
  def is_joint_parliamentary_sitting_day?
    self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
  end
  
  # check if either house is adjourned on a day
  # returns true if one or both Houses are adjourned
  def is_adjournment_day?
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end
  
  # check if the commons is adjourned on a day
  def is_commons_adjournment_day?
    AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 1 ).first
  end
  
  # check if the lords is adjourned on a day
  def is_lords_adjournment_day?
    AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 2 ).first
  end
  
  # check if parliament is prorogued on a day
  def is_prorogation_day?
    ProrogationDay.all.where( 'date = ?',  self ).first
  end
  
  # check if parliament is dissolved on a day
  def is_dissolution_day?
    DissolutionDay.all.where( 'date = ?',  self ).first
  end
  
  # used to check if something / anything has been announced for a date.
  # whether that be a (naive) sitting day, a (naive) virtual sitting day, an adjournment in one or both houses 
  # or a day during a prorogation or dissolution
  def is_announced?
    self.is_commons_praying_sitting_day? or self.is_lords_praying_sitting_day? or self.is_commons_virtual_sitting_day? or self.is_lords_virtual_sitting_day? or self.is_adjournment_day? or self.is_prorogation_day? or self.is_dissolution_day?
  end
  
  # used to check if nothing has yet been announced 
  # whether that be a (naive) sitting day, a (naive) virtual sitting day, an adjournment in one or both houses 
  # or a day during a prorogation or dissolution
  # we use this to check if we've "run out of calendar" so we don't keep cycling into future days and loop infinitely
  # this is our event horizon
  def is_unannounced?
    !self.is_announced?
  end
  
  # Checks if this is a praying adjournment day in the Commons
  # Praying adjournment days are during short periods of adjournment
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  # In all cases we know of, it is a period of not more than 4 days adjourned
  def is_commons_praying_adjournment_day?( maximum_day_count )
    
    # Check if this is an adjournnment day
    if self.is_commons_adjournment_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day in the Commons
        if date.is_commons_adjournment_day?
          
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
        
        # If this is an adjournment day in the Commons
        if date.is_commons_adjournment_day?
          
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
    
    # Check if this is an adjournnment day
    if self.is_lords_adjournment_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day in the Lords
        if date.is_lords_adjournment_day?
          
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
        
        # If this is an adjournment day in the Lords
        if date.is_lords_adjournment_day?
          
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
  
  # END OF METHODS TO WORK OUT WHAT TYPE OF DAY THIS IS
  
  
  # cycles to get first joint sitting day
  # used for pnsis where the clock starts ticking from the first joint sitting day
  # pnsis use parliamentary sitting days
  def first_joint_parliamentary_sitting_day
    
    # If this is an as yet unannounced day...
    if self.is_unannounced?
      
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
  
  # Generate label for the day type in the Commons in a session
  def commons_day_type
    if self.is_commons_parliamentary_sitting_day?
      day_type = 'Sitting day'
    elsif self.is_commons_virtual_sitting_day?
      day_type = 'Virtual sitting day'
    elsif self.is_commons_praying_sitting_day?
      day_type = "Sitting praying day"
    elsif is_commons_adjournment_day?
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
    elsif is_lords_adjournment_day?
      day_type = 'Adjournment day'
    end
    day_type
  end
end