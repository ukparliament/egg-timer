class CalculatorController < ApplicationController
  
  def index
  end
  
  def calculate
    procedure = params["procedure"].to_i
    start_date = params["start-date"]
    day_count = params["day-count"].to_i
    
    # Find the start date in the calendar date table
    @start_date = CalendarDate.find_by_date( start_date )
    
    # Calculate predicted end date for a Proposed Statutory Instrument (PNSI)
    # PNSIs are always before both Houses
    # Proposed negative 10-day scrutiny period
    if procedure == 1
      # Set day counts to 0 for both Houses
      commons_day_count = 0
      lords_day_count = 0
      
      # Count starts first sitting day after laying
      # Find the first joint sitting day following the start date (laying date)
      # For a PNSI the start date is the day of laying
      @date = @start_date.first_joint_sitting_date
      
      # Count 10 Lords sitting days
      # Count 10 Commons sitting days
      # Keep looping through consequitive dates until both the Commons and the Lords have sat for the number of days set
      # Which for a PNSI is 10
      while ( ( commons_day_count <= day_count ) and ( lords_day_count <= day_count ) ) do
        # Go to next date
      
        if @date.next_date
          @date = @date.next_date
        else
          @error_message = 'ran out of calendar'
          break
        end
        
        # Add one to the House count if that House sat that day
        lords_day_count +=1 if @date.is_lords_sitting_day?
        commons_day_count+=1 if @date.is_commons_sitting_day?
      end
    end
    
    
    
    
    
    
    
    
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
    
    
    
    
    
    
    
    
    
    
    
  end
end
