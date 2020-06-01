class SittingDay < ActiveRecord::Base
  
  belongs_to :session
  
  def label
    label = ''
    label = label + self.start_date.strftime( '%-d %B %Y' )
    if self.end_date != self.end_date
      label = label + ' - '
      label = label + self.end_date.strftime( '%-d %B %Y' )
    end
    label
  end
end
