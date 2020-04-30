class Session < ActiveRecord::Base
  
  belongs_to :parliament_period
  
  def label_with_parliament
    label = 'Parliament '
    label = label + self.parliament_period.number.to_s
    label = label + ' Session '
    label = label + self.number.to_s
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_on.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_on.strftime( '%-d %B %Y' ) if self.end_on
    dates
  end
  
  def following_session
    Session.all.where( "start_on > ?", self.end_on ).order( 'start_on' ).first
  end
end
