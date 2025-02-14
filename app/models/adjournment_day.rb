# == Schema Information
#
# Table name: adjournment_days
#
#  id              :integer          not null, primary key
#  date            :date             not null
#  google_event_id :string(255)      not null
#  house_id        :integer          not null
#  recess_date_id  :integer
#  session_id      :integer          not null
#
# Foreign Keys
#
#  fk_house        (house_id => houses.id)
#  fk_recess_date  (recess_date_id => recess_dates.id)
#  fk_session      (session_id => sessions.id)
#
class AdjournmentDay < ActiveRecord::Base
  
  belongs_to :session
  #belongs_to :calendar_date
  belongs_to :recess_date, optional: true
  
  
  def label
    label = ''
    label = label + self.date.strftime( '%-d %B %Y' )
    label
  end
end
