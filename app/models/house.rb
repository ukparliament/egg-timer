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
end
