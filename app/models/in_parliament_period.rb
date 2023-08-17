class InParliamentPeriod
  
  attr_accessor :type
  attr_accessor :number
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :citation
  
  def dates
    dates = ''
    dates = dates + self.start_date.strftime( '%-d %B %Y' )
    dates = dates + ' - '
    dates = dates + self.end_date.strftime( '%-d %B %Y' ) if self.end_date
    dates
  end
end
