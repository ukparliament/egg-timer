class Session < ActiveRecord::Base
  
  belongs_to :parliament_period
  
  def label
    label = ''
    label = self.number.to_s
    label = label + ' (' + self.start_date.strftime( '%e %B %Y' ) + ' - '
    label = label + self.end_date.strftime( '%e %B %Y' ) if self.end_date
    label = label + ')'
    label
  end
  
  def label_with_parliament
    label = 'Parliament '
    label = label + self.parliament_period.number.to_s
    label = label + ' Session '
    label = label + self.number.to_s
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
  
  def following_session_in_parliament
    Session.all.where( "start_date > ?", self.end_date ).where( parliament_period_id: self.parliament_period_id ).order( 'start_date' ).first
  end
end
