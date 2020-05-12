class DissolutionDay < ActiveRecord::Base
  
  belongs_to :dissolution_period
  belongs_to :calendar_date
end
