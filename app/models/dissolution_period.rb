class DissolutionPeriod < ActiveRecord::Base
  
  def label
    label = 'Dissolution '
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
end
