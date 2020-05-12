class AdjournmentDay < ActiveRecord::Base
  
  belongs_to :session
  belongs_to :calendar_date
end
