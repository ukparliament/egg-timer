class CalendarDate < ActiveRecord::Base
  
  def next_date
    CalendarDate.all.where( 'date > ?', self.date ).order( 'date asc' ).first
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
  
  def is_lords_sitting_day?
    sitting_day_flag = false
    sitting_day = SittingDay.all.joins( 'as sdays, sitting_dates as sdates' ).select( 'sdays.*' ).where( 'sdays.house_id = 2' ).where( 'sdates.sitting_day_id = sdays.id' ).where( 'sdates.calendar_date_id = ?', self.id ).order('sdays.id').first
    sitting_day_flag= true if sitting_day
    sitting_day_flag
  end
end
