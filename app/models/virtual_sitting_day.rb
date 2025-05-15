# == Schema Information
#
# Table name: virtual_sitting_days
#
#  id              :integer          not null, primary key
#  end_date        :date             not null
#  start_date      :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  google_event_id :string(255)      not null
#  house_id        :integer          not null
#  session_id      :integer          not null
#
# Foreign Keys
#
#  fk_house    (house_id => houses.id)
#  fk_session  (session_id => sessions.id)
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
