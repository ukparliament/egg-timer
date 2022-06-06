class House < ActiveRecord::Base
  
  has_many :sitting_days, -> { order( 'start_date desc' ) }
  has_many :virtual_sitting_days, -> { order( 'start_date desc' ) }
  has_many :adjournment_days, -> { order( 'date desc' ) }
  
  def sitting_days_in_session( session )
    SittingDay.all.where( house_id: self.id ).where( session_id: session.id ).order( 'start_date asc' )
  end
  
  def virtual_sitting_days_in_session( session )
    VirtualSittingDay.all.where( house_id: self.id ).where( session_id: session.id ).order( 'start_date asc' )
  end
  
  def adjournment_days_in_session( session )
    AdjournmentDay.all.where( house_id: self.id ).where( session_id: session.id ).order( 'date asc' )
  end
  
  def upcoming_sitting_days
    SittingDay.find_by_sql(
      "
        SELECT start_date AS start_date, end_date AS end_date, 'Sitting day' AS day_type
        FROM sitting_days
        WHERE house_id = #{self.id}
        AND start_date > '#{Date.today}'
        ORDER BY start_date ASC
      "
    )
  end
  
  def next_sitting_day
    self.upcoming_sitting_days.first
  end
  
  def preceding_sitting_days
    SittingDay.find_by_sql(
      "
        SELECT start_date AS start_date, end_date AS end_date, 'Sitting day' AS day_type
        FROM sitting_days
        WHERE house_id = #{self.id}
        AND start_date < '#{Date.today}'
        ORDER BY start_date DESC
      "
    )
  end
  
  def latest_sitting_day
    self.preceding_sitting_days.first
  end
  
  def upcoming_virtual_sitting_days
    VirtualSittingDay.find_by_sql(
      "
        SELECT start_date AS start_date, end_date AS end_date, 'Virtual sitting day' AS day_type
        FROM virtual_sitting_days
        WHERE house_id = #{self.id}
        AND start_date > '#{Date.today}'
        ORDER BY start_date ASC
      "
    )
  end
  
  def next_virtual_sitting_day
    self.upcoming_virtual_sitting_days.first
  end
  
  def preceding_virtual_sitting_days
    VirtualSittingDay.find_by_sql(
      "
        SELECT start_date AS start_date, end_date AS end_date, 'Virtual sitting day' AS day_type
        FROM virtual_sitting_days
        WHERE house_id = #{self.id}
        AND start_date < '#{Date.today}'
        ORDER BY start_date DESC
      "
    )
  end
  
  def latest_virtual_sitting_day
    self.preceding_virtual_sitting_days.first
  end
  
  def upcoming_adjournment_days
    AdjournmentDay.find_by_sql(
      "
        SELECT date AS date, date AS start_date, date AS end_date, 'Adjournment day' AS day_type
        FROM adjournment_days
        WHERE house_id = #{self.id}
        AND date > '#{Date.today}'
        ORDER BY date ASC
      "
    )
  end
  
  def next_adjournment_day
    self.upcoming_adjournment_days.first
  end
  
  def preceding_adjournment_days
    AdjournmentDay.find_by_sql(
      "
        SELECT date AS date, date AS start_date, date AS end_date, 'Adjournment day' AS day_type
        FROM adjournment_days
        WHERE house_id = #{self.id}
        AND date < '#{Date.today}'
        ORDER BY start_date DESC
      "
    )
  end
  
  def latest_adjournment_day
    self.preceding_adjournment_days.first
  end
  
  def upcoming
    upcoming = self.upcoming_sitting_days + self.upcoming_virtual_sitting_days + self.upcoming_adjournment_days
    upcoming.sort! { |a, b|  a.start_date <=> b.start_date }
  end
end
