class ProrogationDay < ActiveRecord::Base
  
  belongs_to :prorogation_period
  belongs_to :calendar_date
end
