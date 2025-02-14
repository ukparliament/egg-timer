# == Schema Information
#
# Table name: recess_dates
#
#  id              :integer          not null, primary key
#  description     :string(255)      not null
#  start_date      :date             not null
#  end_date        :date             not null
#  google_event_id :string(255)      not null
#  house_id        :integer          not null
#
class RecessDate < ActiveRecord::Base
  
  belongs_to :house
  has_many :adjournment_days
  
  def display_description
    self.description + ' ' + self.start_date.strftime( '%Y' )
  end
end
