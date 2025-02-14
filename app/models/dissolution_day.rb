# == Schema Information
#
# Table name: dissolution_days
#
#  id                    :integer          not null, primary key
#  date                  :date             not null
#  dissolution_period_id :integer          not null
#  google_event_id       :string(255)
#
# Foreign Keys
#
#  fk_dissolution_period  (dissolution_period_id => dissolution_periods.id)
#
class DissolutionDay < ActiveRecord::Base
  belongs_to :dissolution_period
end
