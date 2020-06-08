class Date
  
  # check if the commons is sitting on a day
  # naive. this is really did the commons sit on this calendar day
  # it might be that this calendar day is a continuation of a previous day's sitting
  # so in a parliament sense it did not "sit" on this day
  def is_the_commons_sitting?
    sitting_day_flag = false
    sitting_day = SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if this was a parliamentary sitting day for the commons
  # does not include dates for which the commons continued sitting from a previous day
  def is_commons_parliamentary_sitting_day?
    sitting_day_flag = false
    sitting_day = SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if the lords is sitting on a day
  # naive. this is really did the lords sit on this calendar day
  # it might be that this calendar day is a continuation of a previous day's sitting
  # so in a parliament sense it did not "sit" on this day
  def is_the_lords_sitting?
    sitting_day_flag = false
    sitting_day = SittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if this was a parliamentary sitting day for the lords
  # does not include dates for which the lords continued sitting from a previous day
  def is_lords_parliamentary_sitting_day?
    sitting_day_flag = false
    sitting_day = SittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if the commons is sitting virtually on a day
  # naive. this is really did the commons sit virtually on this calendar day
  # it might be that this calendar day is a continuation of a previous day's virtual sitting
  # so in a parliament sense it did not "sit" on this day
  def is_the_commons_virtual_sitting?
    sitting_day_flag = false
    sitting_day = VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 1 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if this was a parliamentary virtual sitting day for the commons
  # does not include dates for which the commons continued sitting virtually from a previous day
  def is_commons_parliamentary_sitting_day?
    sitting_day_flag = false
    sitting_day = VirtualSittingDay.all.where( 'start_date = ?',  self ).where( house_id: 1 ).first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  # check if the lords is sitting virtually on a day
  # naive. this is really did the lords sit virtually on this calendar day
  # it might be that this calendar day is a continuation of a previous day's virtual sitting
  # so in a parliament sense it did not "sit" on this day
  def is_the_lords_virtual_sitting?
    # sitting_day_flag = false
#     sitting_day = VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
#     sitting_day_flag= true if sitting_day
#     sitting_day_flag
    VirtualSittingDay.all.where( 'start_date <= ?',  self ).where( 'end_date >= ?',  self ).where( house_id: 2 ).first
  end
  
  # check if this was a parliamentary virtual sitting day for the lords
  # does not include dates for which the lords continued sitting virtually from a previous day
  def is_lords_parliamentary_sitting_day?
    # sitting_day_flag = false
#     sitting_day = VirtualSittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
#     sitting_day_flag= true if sitting_day
#     sitting_day_flag
    VirtualSittingDay.all.where( 'start_date = ?',  self ).where( house_id: 2 ).first
  end
  
  # checks if either House is sitting on a day
  # naive. it might be that this calendar day is a continuation of a previous day's sitting for one or both Houses
  # so in a parliament sense that House did not "sit" on this day
  def is_either_house_sitting?
#     is_sitting_day_flag = false
#     is_sitting_day_flag = true if self.is_the_commons_sitting? or self.is_the_lords_sitting?
#     is_sitting_day_flag
    self.is_the_commons_sitting? or self.is_the_lords_sitting?
  end
  
  # checks if both Houses are sitting on a day
  # naive. it might be that this calendar day is a continuation of a previous day's sitting for one or both Houses
  # so in a parliament sense that House did not "sit" on this day
  def is_joint_sitting?
    # is_sitting_day_flag = false
#     is_sitting_day_flag = true if self.is_the_commons_sitting? and self.is_the_lords_sitting?
#     is_sitting_day_flag
      self.is_the_commons_sitting? and self.is_the_lords_sitting?
  end
  
  # checks if this is a parliamentary sitting day for one or both Houses
  # does not include days continued from previous sitting days
  def is_either_house_parliamentary_sitting?
    # is_sitting_day_flag = false
#     is_sitting_day_flag = true if self.is_commons_parliamentary_sitting_day? or self.is_lords_parliamentary_sitting_day?
#     is_sitting_day_flag
    self.is_commons_parliamentary_sitting_day? or self.is_lords_parliamentary_sitting_day?
  end
  
  # checks if this is a parliamentary sitting day for both Houses
  # does not include days continued from previous sitting days
  def is_joint_parliamentary_sitting?
    # is_sitting_day_flag = false
#     is_sitting_day_flag = true if self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
#     is_sitting_day_flag
    self.is_commons_parliamentary_sitting_day? and self.is_lords_parliamentary_sitting_day?
  end
  
  # check if either house is adjourned on a day
  # returns true if one or both Houses are adjourned
  def is_adjournment_day?
    # adjournment_day_flag = false
#     adjournment_day = AdjournmentDay.all.where( 'date = ?',  self ).first
#     adjournment_day_flag= true if adjournment_day
#     adjournment_day_flag
    AdjournmentDay.all.where( 'date = ?',  self ).first
  end
  
  # check if the commons is adjourned on a day
  def is_commons_adjournment_day?
    # adjournment_day_flag = false
#     adjournment_day = AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 1 ).first
#     adjournment_day_flag= true if adjournment_day
#     adjournment_day_flag
    AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 1 ).first
  end
  
  # check if the lords is adjourned on a day
  def is_lords_adjournment_day?
    # adjournment_day_flag = false
#     adjournment_day = AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 2 ).first
#     adjournment_day_flag= true if adjournment_day
#     adjournment_day_flag
     AdjournmentDay.all.where( 'date <= ?',  self ).where( house_id: 2 ).first
  end
  
  # check if parliament is prorogued on a day
  def is_prorogation_day?
    # prorogation_day_flag = false
#     prorogation_day = ProrogationDay.all.where( 'date = ?',  self ).first
#     prorogation_day_flag= true if prorogation_day
#     prorogation_day_flag
    ProrogationDay.all.where( 'date = ?',  self ).first
  end
  
  # check if parliament is dissolved on a day
  def is_dissolution_day?
    # dissolution_day_flag = false
#     dissolution_day = DissolutionDay.all.where( 'date = ?',  self ).first
#     dissolution_day_flag= true if dissolution_day
#     dissolution_day_flag
    DissolutionDay.all.where( 'date = ?',  self ).first
  end
  
  # used to check if nothing has yet been announced 
  # whether that be a (naive) sitting day, a (naive) virtual sitting day, an adjournment in one or both houses 
  # or a day during a prorogation or dissolution
  # we use this to check if we've "run out of calendar" so we don't keep cycling into future days and loop infinitely
  # this is our event horizon
  def is_unannounced?
    is_unannounced = true
    is_unannounced = false if self.is_the_commons_sitting? or self.is_the_lords_sitting? or self.is_the_commons_virtual_sitting? or self.is_the_lords_virtual_sitting? or self.is_adjournment_day? or self.is_prorogation_day? or self.is_dissolution_day?
    is_unannounced
  end
  

  
  
  
  
  
  
  
  # edited to here
  
  
  
  
  
  # cycles to get first joint sitting day
  def first_joint_sitting_day
    
    # If this is an as yet unannounced day...
    if self.is_unannounced?
      
      # ...give up finding a first joint sitting day
      return nil
    
    # If this isn't an as yet unnanounced day...
    else
      
      # ...if this is not a joint sitting day, go check the next one
      unless self.is_joint_sitting_day?
        self.next_day.first_joint_sitting_day
        
      # ..if this is a joint sitting day, return it
      else
        self
      end
    end
  end
  
  
  
  # cycles to get first sitting day in either House
  #def first_sitting_day
    #unless self.is_sitting_day?
      #self.next_day.first_sitting_day
      #else
      #self
      #end
  #end
  

  

  

  


  
  
  
  
  
  
  
  
  
  

  

  
  # Checks if this is a short adjournment date in the Commons
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  def is_commons_short_adjournment?( maximum_day_count )
    
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
  
  # Checks if this is a short adjournment date in both Houses
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  def is_short_adjournment?( maximum_day_count )
    
    # Check if this is an adjournnment day in both Houses
    if self.is_commons_adjournment_day? and self.is_lords_adjournment_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day in the Commons and the Lords
        if date.is_commons_adjournment_day? and date.is_lords_adjournment_day?
          
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
        
        # If this is an adjournment day in the Commons and the Lords
        if date.is_commons_adjournment_day? and date.is_lords_adjournment_day?
          
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
        is_short_adjournment = false
      
      # If this is 4 or more days adjournment...
      else  
      
        # ....this is a short adjournnment and does count on the clock
        is_short_adjournment = true
      end
      is_short_adjournment
    end
  end
  
  # Checks if this is a short adjournment date in one or both Houses
  # The definition of "short is adjustable" by passing in a maximum number of days to count as "short"
  def is_either_house_short_adjournment?( maximum_day_count )
    
    # Check if this is an adjournnment day in one or both Houses
    if self.is_commons_adjournment_day? or self.is_lords_adjournment_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_day
        
        # If this is an adjournment day in the Commons or the Lords
        if date.is_commons_adjournment_day? or date.is_lords_adjournment_day?
          
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
        
        # If this is an adjournment day in the Commons or the Lords
        if date.is_commons_adjournment_day? or date.is_lords_adjournment?
          
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
        is_either_house_short_adjournment = false
      
      # If this is 4 or more days adjournment...
      else  
      
        # ....this is a short adjournnment and does count on the clock
        is_either_house_short_adjournment = true
      end
      is_either_house_short_adjournment
    end
  end
end