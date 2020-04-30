class ProrogationPeriod < ActiveRecord::Base
  
  belongs_to :parliament_period
  
  def label_with_parliament
    label = 'Parliament '
    label = label + self.parliament_period.number.to_s
    label = label + ' Prorogation '
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
