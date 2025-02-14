# == Schema Information
#
# Table name: virtual_sitting_days
#
#  id              :integer          not null, primary key
#  start_date      :date             not null
#  end_date        :date             not null
#  google_event_id :string(255)      not null
#  session_id      :integer          not null
#  house_id        :integer          not null
#
class VirtualSittingDay < ActiveRecord::Base
  
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
