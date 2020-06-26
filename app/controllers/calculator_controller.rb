# # Calculating the scrutiny period
class CalculatorController < ApplicationController
  
  # This is the code to generate the form that people can fill in.
  # Set a title for the page people see.
  def index
  	@title = "Calculate scrutiny periods"
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
  
  # Having filled in the form and pressed 'Calculate' this code runs to do the calculation.
  # In order to calculate the scrutiny period, we need:
  def calculate
	  @title = "Calculated scrutiny period"
    
	  # * the **type of the procedure** itself, which we refer to by a number
    procedure = params["procedure"].to_i if params["procedure"]
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params["start-date"]
    
    # Check that all the parameters have been provided by the form
    # And if not throw an error
    if params['start-date'].blank? or params['day-count'].blank? or params['day-count'].to_i == 0 or procedure.nil?
	    @title = "Sorry, there was not enough information provided."
      render :template => 'calculator/not_enough_information'
      
    # If the form did provide all the required information, do the calculation.
    else
      
      # * find the procedure in the database
      @procedure = Procedure.find( procedure )
      
      # * the **number of days** to count
      @day_count = params["day-count"].to_i
      
      # * make the date passed into a date the code understands...
      @start_date = Date.parse( start_date )
      
      # Depending upon the procedure specified, we run the appropriate calculation
      case @procedure.id
        
      # Calculate the **anticipated end date** for Legislative Reform Orders, Localism Orders, Public Bodies Orders and treaty period A:
      when 1, 2, 4, 10
        
        ##### call calculation style 1
        @end_date = bicameral_parliamentary_days_calculation( @start_date, @day_count )
      
      # Calculate the **anticipated end date** for a Proposed Statutory Instrument (PNSI):
      when 3
        
        #### call calculation style 2
        @end_date = bicameral_first_to_ten_calculation( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for a Commons only negative Statutory Instrument
      when 5, 7
    
        #### call calculation style 3
        @end_date = commons_praying_days_calculation( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for a Commons and Lords negative Statutory Instrument or a Commons and Lords affirmative Statutory Instrument where either House is sitting
      when 6, 9
         
        #### call calculation style 4
        @end_date = bicameral_praying_days_calculation_either_house_sitting( @start_date, @day_count ) 
        
      # Calculate the **anticipated end date** for a Commons and Lords affirmative Statutory Instrument where both Houses sitting
      when 8
       
        #### call calculation style 5
        @end_date = bicameral_praying_days_calculation_both_houses_sitting( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for treaty period B:
      when 11
      
        #### call calculation style 6
        @end_date = commons_parliamentary_days_calculation( @start_date, @day_count )
      else
        @error_message = "Sorry, this procedure is not currently supported."
      end
    end
  end
end

# Calculation style 1
# A method for calculating based on "bums on seats" in both Houses
# Where both Houses must be sitting to count (Commons AND Lords)
# Used for treaty period A, LROs, LOs, PBOs
def bicameral_parliamentary_days_calculation( date, target_day_count )
  
  # Get ready to count praying days in the House of Commons
  # If this is not a parliamentary sitting day for both Houses find the first parliamentary sitting day and start counting from there
  date = date.first_joint_parliamentary_sitting_day unless date.is_joint_parliamentary_sitting_day?
  # days start counting from 1
  day_count = 1
  
  # ... we look at subsequent days, ensuring that we've counted at least the set number of joint parliamentary sitting days.
  while ( day_count < target_day_count ) do
    
    # Go to the next day
    date = date.next_day
    
    # Add 1 to the day count if this is a joint parliamentary sitting day
    day_count +=1 if date.is_joint_parliamentary_sitting_day?
    
    puts "*****"
    puts date
    puts day_count
    
    # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
    # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
    if date.is_unannounced?
      
      # This error message is displayed to users.
      @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
      break
    end
  end
  
  # Return date for display on page
  date
end

# Calculation style 2
# A method for calculating committee scrutiny periods for PNSIs
# Based on parliamentary sitting days
# Counted from first joint sitting day, then last House to 10
def bicameral_first_to_ten_calculation( date, target_day_count )
  
  # We start counting on the **first day when both Houses are sitting** after the instrument is laid.
  # If we find the **first joint sitting day** following the start date, the laying date in this case, ...
  if date.next_day.first_joint_parliamentary_sitting_day
    date = date.next_day.first_joint_parliamentary_sitting_day

  	# PNSIs are always before both Houses, so we'll get ready to start counting the sitting days in each House.
    # The first joint sitting day counts as day 1, so we count from 1, not 0
    commons_day_count = 1
    lords_day_count = 1
    
    # ... we look at subsequent days, ensuring that we've counted at least the set number of sitting days to count in each House. In the case of a PNSI, that's ten days.
    while ( ( commons_day_count < target_day_count ) or ( lords_day_count < target_day_count ) ) do

      # Go to the **next day**
      date = date.next_day

      # PNSIs use parliamentary sitting days and no naive calendar days
      # If the Lords sat on the date we've found, we add another day to the count.
      lords_day_count +=1 if date.is_lords_parliamentary_sitting_day?
      # If the Commons sat on the date we've found, we add another day to the count.
      commons_day_count+=1 if date.is_commons_parliamentary_sitting_day?
  
      # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
      # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
      if date.is_unannounced?
        
        # This error message is displayed to users.
        @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
        break
      end
    end

# If we didn't find any **future joint sitting date** in our calendar, we can't calculate the scrutiny period - and we show an error message.
  else
    
    # This error message is displayed to users.
    @error_message = "Unable to find a future joint sitting day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
  end
  
  # Return date for display on page
  date
end

# Calculation style 3
# Used for Commons only negative SIs
# Counts through short adjournments (not bums on seats)
def commons_praying_days_calculation( date, target_day_count )
  
  # Get ready to count praying days in the House of Commons
  # If this is not a praying day for the Commons...
  unless date.is_commons_praying_day?
    
    # If there is a future Commons praying day
    if date.first_commons_praying_day 
      
      # Set the date to the first Commons praying day
      date = date.first_commons_praying_day 
      
    # If we didn't find any **future Commons praying day* in our calendar, we can't calculate the scrutiny period - and we show an error message and stop running this code.
    else
  
      # This error message is displayed to users.
      @error_message = "Unable to find a future House of Commons praying day. It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
      return
    end
  end
    
  # We've found the first praying day so start from 1
  day_count = 1

  # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
  while ( day_count < target_day_count ) do
    
    # Skip to the next calendar day
    date = date.next_day
    
    # If the date we've found was a Commons praying day, we add another day to the count.
    day_count +=1 if date.is_commons_praying_day?
    
    # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
    # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
    if date.is_unannounced?
      
      # This error message is displayed to users unless an error message was set earlier
      @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
       break
    end
  end
  
  # Return date for display on page
  date
end

# Calculation style 4
# Used for Commons and Lords negative SIs and some Commons and Lords affirmative SIs
# Counts when Commons OR Lords are sitting
# Counts through short adjournments (not bums on seats)
def bicameral_praying_days_calculation_either_house_sitting( date, target_day_count )
  
  # Get ready to count praying days in the House of Commons or House of Lords
  # If this is not a praying day for either House find the first praying day and start counting from there
  date = date.first_praying_day_in_either_house unless date.is_either_house_praying_day?
  
  # We've found the first praying day so start from 1
  day_count = 1

  # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
  while ( day_count < target_day_count ) do
    
    # Skip to the next calendar day
    date = date.next_day
    
    # If the date we've found was either a Commons or a Lords praying day, we add another day to the count.
    day_count +=1 if date.is_either_house_praying_day?
    
    # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
    # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
    if date.is_unannounced?
      @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
      break
    end
  end
  
  # Return date for display on page
  date
end

# Calculation style 5
# Used for some Commons and Lords made affirmative SIs
# Counts when Commons AND Lords are sitting
# Counts through short adjournments (not bums on seats)
def bicameral_praying_days_calculation_both_houses_sitting( date, target_day_count )
  
  # Get ready to count praying days in the House of Commons and House of Lords
  # Clock starts on day of laying so start from 1
  day_count = 1

  # ... we look at each of our calendar dates, ensuring that we've counted the set number of days to count.
  while ( day_count < target_day_count ) do
    
    # If the date we've found was both a Commons and a Lords praying day, we add another day to the count.
    day_count +=1 if date.is_commons_praying_day? and date.is_lords_praying_day?
    
    # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
    # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
    if date.is_unannounced?
      @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
      break
    
    # Otherwise, continue to the next day and count again
    else
      # Skip to the next calendar day and count again
      date = date.next_day
    end
  end
  
  # Return date for display on page
  date
end

# Calculation style 6
# A method for calculating based on "bums on seats" in Commons only
# Used for treaty period B
def commons_parliamentary_days_calculation( date, target_day_count )
  # days start counting from 1
  day_count = 1
  
  # ... we look at subsequent days, ensuring that we've counted at least the set number of commons parliamentary sitting days.
  while ( day_count < target_day_count ) do
    
    # Go to the next day
    date = date.next_day
    
    # Add 1 to the day count if this is a joint parliamentary sitting day
    day_count +=1 if date.is_commons_parliamentary_sitting_day?
    
    # Stop looping if the date is not a sitting day, not an adjournment day, not a prorogation day and not a dissolution day
    # If we have no record for this day yet, we can't calculate the end date - and we show an error message.
    if date.is_unannounced?
      
      # This error message is displayed to users.
      @error_message = "It's not currently possible to calculate an anticipated end date, as the likely end date occurs during a period for which sitting days are yet to be announced."
      break
    end
  end
  
  # Return date for display on page
  date
end