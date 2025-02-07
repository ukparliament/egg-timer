# == Schema Information
#
# Table name: prorogation_days
#
#  id                    :integer          not null, primary key
#  date                  :date             not null
#  google_event_id       :string(255)
#  prorogation_period_id :integer          not null
#
class ProrogationDay < ActiveRecord::Base
  
  belongs_to :prorogation_period
  belongs_to :calendar_date
end
