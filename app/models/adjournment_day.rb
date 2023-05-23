class AdjournmentDay < ActiveRecord::Base
  
  belongs_to :session
  belongs_to :calendar_date
  belongs_to :recess_date, optional: true
  
  
  def label
    label = ''
    label = label + self.date.strftime( '%-d %B %Y' )
    label
  end
end
