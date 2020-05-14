class House < ActiveRecord::Base
  
  has_many :sitting_days
  has_many :adjournment_days
  
  def sitting_days_in_session( session )
    SittingDay.all.where( house_id: self.id ).where( session_id: session.id )
  end
  
  def adjournment_days_in_session( session )
    AdjournmentDay.all.where( house_id: self.id ).where( session_id: session.id )
  end
end
