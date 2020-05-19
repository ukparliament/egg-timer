class ParliamentPeriod < ActiveRecord::Base
  
  has_many :sessions, -> { order( 'start_date desc' ) }
  has_many :prorogation_periods, -> { order( 'start_date desc' ) }
  
  def label
    label = self.number.ordinalize + " Parliament"
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
  
  def following_parliament_period
    ParliamentPeriod.all.where( "start_date > ?", self.end_date ).order( 'start_date' ).first
  end
end
