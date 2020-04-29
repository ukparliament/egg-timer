class ParliamentPeriod < ActiveRecord::Base
  
  has_many :sessions, -> { order( 'start_on desc' ) }
  
  def label
    label = 'Parliament '
    label = label + self.number.to_s
    label
  end
  
  def dates
    dates = ''
    dates = dates + self.start_on.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.start_on.strftime( '%-d %B %Y' ) if self.end_on
    dates
  end
end
