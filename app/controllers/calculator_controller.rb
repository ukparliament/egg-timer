require 'calculations/BICAMERAL_PARLIAMENTARY_DAYS'
#require 'CALCULATIONS/BICAMERAL_FIRST_TO_TEN'
#require 'CALCULATIONS/COMMONS_PRAYING_DAYS'
#require 'CALCULATIONS/BICAMERAL_PRAYING_DAYS_EITHER_HOUSE_SITTING'
#require 'CALCULATIONS/BICAMERAL_PRAYING_DAYS_BOTH_HOUSES_SITTING'
#require 'CALCULATIONS/TREATY_PERIOD_A'
#require 'CALCULATIONS/COMMONS_PARLIAMENTARY_DAYS'

# # Calculating the scrutiny period
class CalculatorController < ApplicationController
  
  include CALCULATION_BICAMERAL_PARLIAMENTARY_DAYS
  #include CALCULATION_BICAMERAL_FIRST_TO_TEN
  #include CALCULATION_COMMONS_PRAYING_DAYS
  #include CALCULATION_BICAMERAL_PRAYING_DAYS_EITHER_HOUSE_SITTING
  #include CALCULATION_BICAMERAL_PRAYING_DAYS_BOTH_HOUSES_SITTING
  #include CALCULATION_TREATY_PERIOD_A
  #include CALCULATION_COMMONS_PARLIAMENTARY_DAYS
  
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
        
      # Calculate the **anticipated end date** for Legislative Reform Orders, Localism Orders and Public Bodies Orders:
      when 1, 2, 4
        @end_date = bicameral_parliamentary_days_calculation( @start_date, @day_count )
      
      # Calculate the **anticipated end date** for a Proposed Statutory Instrument (PNSI):
      when 3
        @end_date = bicameral_first_to_ten_calculation( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for a Commons only negative Statutory Instrument and some made affirmatives
      when 5, 7
        @end_date = commons_praying_days_calculation( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for a Commons and Lords negative Statutory Instrument or a Commons and Lords affirmative Statutory Instrument where either House is sitting
      when 6, 9
        @end_date = bicameral_praying_days_calculation_either_house_sitting( @start_date, @day_count ) 
        
      # Calculate the **anticipated end date** for a Commons and Lords affirmative Statutory Instrument where both Houses sitting
      when 8
        @end_date = bicameral_praying_days_calculation_both_houses_sitting( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for treaty period A:
      when 10
        @end_date = treaty_period_a_calculation( @start_date, @day_count )
        
      # Calculate the **anticipated end date** for treaty period B:
      when 11
        @end_date = commons_parliamentary_days_calculation( @start_date, @day_count )
      else
        @error_message = "Sorry, this procedure is not currently supported."
      end
    end
  end
end













