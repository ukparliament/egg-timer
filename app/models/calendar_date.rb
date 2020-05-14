class CalendarDate < ActiveRecord::Base
  
  def next_date
    CalendarDate.all.where( 'date > ?', self.date ).order( 'date asc' ).first
  end
  
  def previous_date
    CalendarDate.all.where( 'date < ?', self.date ).order( 'date desc' ).first
  end
  
  def first_joint_sitting_date
    if self.next_date
      next_date = self.next_date
      unless next_date.is_joint_sitting_day?
        next_date.first_joint_sitting_date
      else
        next_date
      end
    end
  end
  
  def is_joint_sitting_day?
    is_joint_sitting_day_flag = false
    is_joint_sitting_day_flag = true if self.is_commons_sitting_day? and self.is_lords_sitting_day?
    is_joint_sitting_day_flag
  end
  
  def is_commons_sitting_day?
    sitting_day_flag = false
    sitting_day = SittingDay.all.joins( 'as sdays, sitting_dates as sdates' ).select( 'sdays.*' ).where( 'sdays.house_id = 1' ).where( 'sdates.sitting_day_id = sdays.id' ).where( 'sdates.calendar_date_id = ?', self.id ).order('sdays.id').first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  def is_commons_adjournment_day?
    is_commons_adjournment_day = false
    adjournment_day = AdjournmentDay.all.where( house_id: 1).where( calendar_date_id: self.id).first
    is_commons_adjournment_day = true if adjournment_day
    is_commons_adjournment_day
  end
  
  def is_lords_sitting_day?
    sitting_day_flag = false
    sitting_day = SittingDay.all.joins( 'as sdays, sitting_dates as sdates' ).select( 'sdays.*' ).where( 'sdays.house_id = 2' ).where( 'sdates.sitting_day_id = sdays.id' ).where( 'sdates.calendar_date_id = ?', self.id ).order('sdays.id').first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
  
  def is_commons_short_adjournment?( maximum_day_count )
    is_commons_short_adjournment = false
    # If this day is an adjournment day in the Commons...
    if self.is_commons_adjournment_day?
      
      # Set the adjournment day count to start at 1
      adjournment_day_count = 1
      
      # Cycle through the following days according to the maximum day count passed in.
      date = self
      for i in ( 1..maximum_day_count )
        
        # Go forward one day
        date = date.next_date
        
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
        date = date.previous_date
        
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
      
        # this is not a short adjournment and does not count on the clock
        is_commons_short_adjournment = false
      
      # If this is 4 or more days adjournment...
      else  
      
        # this is a short adjournemtn and does count on the clock
        is_commons_short_adjournment = true
      end
      is_commons_short_adjournment
    end
  end
end
