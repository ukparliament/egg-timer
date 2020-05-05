class CalculatorController < ApplicationController
  
  def index
  end
  
  def calculate
    # max day count = 40
    # day type = sitting / sitting-period-day
    # start date = today
    # procedure
    # houses
    
    
    # sis
    #day_count = 0
    #loop from start date thru consecutive days |day|
    # sitting days
    #if day is commons sitting or lords sitting
      #day_count++
    # adjourned days within a sitting period where adjournment is <= 5 days
    #or if day is in a block of adjournment days <= 5
      #day_count++
    #or long adjournment
      #do nowt
      #end
    #if day_count = maxdaycount
      #return day
      #end
    
    # LROs
    #day_count = 0
    #loop from start date thru consecutive days |day|
    # sitting days
    #if day is commons sitting and lords sitting
      #day_count++
    # adjourned days within a sitting period where adjournment is <= 5 days
    #or if day is in a block of adjournment days <= 5
      #day_count++
    #or long adjournment
      #do nowt
      #end
    #if day_count = maxdaycount
      #return day
      #end
    
    # treaty
    #day_count = 0
    #loop thru consecutive days until
      #first joint sitting day
      # this be day 0
      #loop thru consecutive *sitting days* (through sitting date) |day|
      #is sitting day a continuation of previous sitting day
      # sitting_day.is_continuation? 
      #do now
      #else day is commons sitting and lords sitting
       #   day_count++
        #else
         # do nowt
        #end
        #if day_count = maxday count 
         # return day
        #end
        #end
    #end
    
    # euwa
    #day_count = 0
    #loop from start date (making) thru consecutive days |day|
    # sitting days
    #if day is commons sitting and lords sitting
      #day_count++
    # adjourned days within a sitting period where adjournment is <= 5 days
    #else
      #do nowt
      #end
    #if day_count = maxdaycount
      #return day
      #end
    
    # pnsi
    #commons_day_count = 0
    #lords_day_count = 0
    #loop thru consecutive days until
      #first joint sitting day
      # this be day 0
      #loop thru consecutive days |day|
        #if day is commons sitting
          #commons_day_count++
          #end
        #if lords sitting
          #lords_day_count++
          #end
        
        #if commons_day_count => 10 and lords day count => 10
          #return day
          #end
        
      #end
      #end
    
    
    
    
    
    
    
    
    
  end
end
