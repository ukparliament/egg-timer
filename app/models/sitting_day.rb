class SittingDay < ActiveRecord::Base
  
  belongs_to :session
  has_many :sitting_dates
  has_many :calendar_dates,
    through: :sitting_dates
  
  def label
    label = ''
    label = label + self.sitting_dates.first.calendar_date.date.strftime( '%-d %B %Y' )
    if self.sitting_dates.size > 1
      label = label + ' - '
      label = label + self.sitting_dates.last.calendar_date.date.strftime( '%-d %B %Y' )
    end
    label
  end
end
