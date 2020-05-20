# # Calculating the scrutiny period
class CalculatorController < ApplicationController
  
  # Set a title for the page people see.
  def index
  	@title = "Calculate scrutiny periods"
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
  
  # In order to calculate the scrutiny period, we need:
  def calculate
	@title = "Calculated scrutiny period"
	# * the **type of the procedure** itself, which we refer to by a number
    procedure = params["procedure"].to_i
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params["start-date"]
    
    # Check that all the parameters have been provided by the form
    # And if not throw an error
    if params['start-date'].blank? or params['day-count'].blank? or params['day-count'].to_i == 0
	    @title = "Sorry, there was not enough information provided."
      render :template => 'calculator/not_enough_information'
      
    # If the form did provide all the required information, do the calculation.
    else
      
      # Find the procedure
      @procedure = Procedure.find( procedure )
      
      # * the **number of days** to count
      @day_count = params["day-count"].to_i
    
  	  # Make the date passed into a date the code understands...
      @start_date = Date.parse( start_date )
      
      # Calculate the **anticipated end date** for a Proposed Statutory Instrument (PNSI):
      if @procedure.id == 3
    
        # We start counting on the **first day when both Houses are sitting** after the instrument is laid.
        # If we find the **first joint sitting day** following the start date, the laying date in this case, ...
        if @start_date.next_day.first_joint_sitting_day
          @clock_date = @start_date.next_day.first_joint_sitting_day
        

        	# PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
          # The first joint sitting day counts as day 1, so we count from 1, not 0
          commons_day_count = 1
          lords_day_count = 1
          
          # ... we look at subsequent days, ensuring that we've counted at least the set number of sitting days to count in each House. In the case of a PNSI, that's ten days.
          while ( ( commons_day_count < @day_count ) and ( lords_day_count < @day_count ) ) do
      
            # Go to the next day**
            @clock_date = @clock_date.next_day
    	
            # If the Lords sat on the date we've found, we add another day to the count.
            lords_day_count +=1 if @clock_date.is_lords_sitting_day?
            # If the Commons sat on the date we've found, we add another day to the count.
            commons_day_count+=1 if @clock_date.is_commons_sitting_day?
        
            # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
            # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
            if @clock_date.is_unannounced?
              @error_message = "An anticipated end date can’t be shown. Enough future sitting dates should be set in the calendar in order for the anticipated end date to be calculated."
              break
            end
          end
    	
  	# If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period - and we show an error message.
        else
          @error_message = "An anticipated end date can’t be shown. The next joint sitting day should be set in the calendar in order for the anticipated end date to be calculated."
        end
      end
    
      # ... we can calculate the **anticipated end date** for a Commons only negative Statutory Instrument
      if @procedure.id == 5
      
        # Counting of "sitting days" starts on day of laying
        @clock_date = @start_date
        
        # Get ready to count days off in the House of Commons only
        # Clock starts on day of laying so start from 1
        day_count = 1
      
        # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
        while ( day_count < @day_count ) do
          
        
          # If the Commons sat on the date we've found, we add another day to the count.
          if @clock_date.is_commons_sitting_day?
            day_count +=1
        
          # If the Commons was adjourned and was adjourned for a period of not more than 4 days, we add another day to the count.
          # Passing in the maximum number of days that counts as short in this case
          elsif @clock_date.is_commons_short_adjournment?( 4 )
            day_count +=1
          end
          
          # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
          # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
          if @clock_date.is_unannounced?
            @error_message = "An anticipated end date can’t be shown. Enough future sitting dates should be set in the calendar in order for the anticipated end date to be calculated."
            break
          
          # Otherwise, continue to the next day and count again
          else
            # Skip to the next calendar day and count again
            @clock_date = @clock_date.next_day
          end
        end
      end
      
      # ... we can calculate the **anticipated end date** for a Commons and Lords negative Statutory Instrument
      if @procedure.id == 6
      
        # Counting of "sitting days" starts on day of laying
        @clock_date = @start_date
        
        # Get ready to count days off in the House of Commons and House of Lords
        # Clock starts on day of laying so start from 1
        day_count = 1
      
        # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
        while ( day_count < @day_count ) do
          
        
          # If the Commons or the Lords sat on the date we've found, we add another day to the count.
          if @clock_date.is_commons_sitting_day? or @clock_date.is_lords_sitting_day?
            day_count +=1
        
          # If the Commons and the Lords were both adjourned and were adjourned for a period of not more than 4 days, we add another day to the count.
          # Passing in the maximum number of days that counts as short in this case
          elsif @clock_date.is_short_adjournment?( 4 )
            day_count +=1
          end
          
          # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
          # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
          if @clock_date.is_unannounced?
            @error_message = "An anticipated end date can’t be shown. Enough future sitting dates should be set in the calendar in order for the anticipated end date to be calculated."
            break
          
          # Otherwise, continue to the next day and count again
          else
            # Skip to the next calendar day and count again
            @clock_date = @clock_date.next_day
          end
        end
      end
      
      # ... we can calculate the **anticipated end date** for a Commons only made affirmative Statutory Instrument
      
      # ... we can calculate the **anticipated end date** for a Commons and Lords made affirmative Statutory Instrument
      if @procedure.id == 8
      
        # Counting of "sitting days" starts on day of making
        @clock_date = @start_date
        
        # Get ready to count days off in the House of Commons and House of Lords
        # Clock starts on day of making so start from 1
        day_count = 1
      
        # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
        while ( day_count < @day_count ) do
          
        
          # If the Commons and the Lords sat on the date we've found, we add another day to the count.
          if @clock_date.is_commons_sitting_day? and @clock_date.is_lords_sitting_day?
            day_count +=1
        
          # If either the Commons or the Lords were adjourned and were adjourned for a period of not more than 4 days, we add another day to the count.
          # Passing in the maximum number of days that counts as short in this case
          elsif @clock_date.is_either_house_short_adjournment?( 4 )
            day_count +=1
          end
          
          # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
          # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
          if @clock_date.is_unannounced?
            @error_message = "An anticipated end date can’t be shown. Enough future sitting dates should be set in the calendar in order for the anticipated end date to be calculated."
            break
          
          # Otherwise, continue to the next day and count again
          else
            # Skip to the next calendar day and count again
            @clock_date = @clock_date.next_day
          end
        end
      end
    end
  end
end
