# # Calculating the scrutiny period
class CalculatorController < ApplicationController
  
  # Set a title for the page people see.
  def index
  	@title = "Calculate scrutiny periods"
  end
  
  # In order to calculate the scrutiny period, we need:
  def calculate
	@title = "Calculated scrutiny period"
	# * the **type of the procedure** itself, which we refer to by a number
    procedure = params["procedure"].to_i
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params["start-date"]
    
    # * the **number of days** to count
    @day_count = params["day-count"].to_i
    
	# If the start date is in our calendar dates list ...
    if CalendarDate.all.where( 'date = ?', start_date ).first
      @start_date = CalendarDate.find_by_date( start_date )
    
      # ... we can calculate the **anticipated end date** for a Proposed Statutory Instrument (PNSI):
      
      if procedure == 1
      	# PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
        commons_day_count = 0
        lords_day_count = 0
      
        # We start counting on the **first joint sitting day** after the instrument is laid.
        # If we find the **first joint sitting day** following the start date, the laying date in this case, ...
        if @start_date.first_joint_sitting_date
          @date = @start_date.first_joint_sitting_date
          
          # ... we look at each of our calendar dates, ensuring that we've counted at least the set number of sitting days to count in each House. In the case of a PNSI, that's ten days.
          while ( ( commons_day_count <= @day_count ) and ( lords_day_count <= @day_count ) ) do
          
            # If we have found a date that matches the criteria in the calendar, **success!**
            if @date.next_date
              @date = @date.next_date
            else
              # If we haven't found a date in the calendar, ...
              @error_message = "Ooops. We've run out of calendar."
              # ... __we give up__.
              break
            end
        	
            # If the Lords sat on the date we've found, we add another day to the count.
            lords_day_count +=1 if @date.is_lords_sitting_day?
            # If the Commons sat on the date we've found, we add another day to the count.
            commons_day_count+=1 if @date.is_commons_sitting_day?
          end
      	
		# If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period - and we show an error message.
        else
          @error_message = "Ooops. We've run out of calendar."
        end
      end
  
    # If the **start date** isn't in our calendar dates list, we can't calculate the scrutiny period - and we show an error message.
    else
      @error_message = "Ooops. We've run out of calendar."
    end
  end
end
