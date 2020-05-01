class SittingDate < ActiveRecord::Base
  
  belongs_to :sitting_day
  belongs_to :calendar_date
end
