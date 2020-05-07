# # This is our calculation code!
class CalculatorController < ApplicationController
  
  # Set a title for the page people see.
  def index
  	@title = "Calculate scrutiny periods"
  end
  
  # In order to calculate the scrutiny period, we need:
  def calculate

	# * the type of the procedure itself, which we refer to by a number
    procedure = params["procedure"].to_i
    
    # * the start date, for example: "2020-05-06"
    start_date = params["start-date"]
    
    # * the number of days to count
    @day_count = params["day-count"].to_i
    
	# If the start date is in our calendar dates list ...
    if CalendarDate.all.where( 'date = ?', start_date ).first
      @start_date = CalendarDate.find_by_date( start_date )
    
      # Calculate the anticipated end date for a Proposed Statutory Instrument (PNSI)
      # PNSIs are always before both Houses
      if procedure == 1
        # Set day counts to 0 for both Houses. These will increment for sitting downs found in a House
        commons_day_count = 0
        lords_day_count = 0
      
        # Count starts first joint sitting day after laying
        # Find the first joint sitting day following the start date (laying date in this case) - if there is one
        if @start_date.first_joint_sitting_date
          @date = @start_date.first_joint_sitting_date
      
          # Count 10 Lords sitting days
          # Count 10 Commons sitting days
          # Keep looping through consecutive dates until both the Commons and the Lords have sat for the number of days set
          # Which for a PNSI is 10
          # Do this loop until it has counted at least 10 days in the commons and at least 10 days in the lords
          while ( ( commons_day_count <= @day_count ) and ( lords_day_count <= @day_count ) ) do
            # Go to next date if there is one
            if @date.next_date
              @date = @date.next_date
            else
              # If there is no next date show error message and stop looping
              @error_message = "Ooops. We've run out of calendar."
              break
            end
        	
			# Add one to the House count if that House sat that day
            
            lords_day_count +=1 if @date.is_lords_sitting_day?
            commons_day_count+=1 if @date.is_commons_sitting_day?
          end
      	
		# If there is no future joint sitting date raise an error
        else
          @error_message = "Ooops. We've run out of calendar."
        end
      end
  
    # If the start date isn't in our calendar dates list, we can't calculate the scrutiny period.
    
    else
      @error_message = "Ooops. We've run out of calendar."
    end
  end
end
