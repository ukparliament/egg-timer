# == Schema Information
#
# Table name: dissolution_days
#
#  id                    :integer          not null, primary key
#  date                  :date             not null
#  google_event_id       :string(255)
#  dissolution_period_id :integer          not null
#
class DissolutionDay < ActiveRecord::Base
  
  belongs_to :dissolution_period
  belongs_to :calendar_date
end
