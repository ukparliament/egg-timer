class AdjournmentDay < ActiveRecord::Base
  
  belongs_to :session
  belongs_to :calendar_date
  
  def label
    label = ''
    label = label + self.calendar_date.date.strftime( '%-d %B %Y' )
    label
  end
end
