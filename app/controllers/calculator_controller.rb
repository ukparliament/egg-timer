# # Calculator controller to build the form and run the calculations.

# Individual calculations for different flavours of instrument are packaged into separate files. This code requires those files to be loaded.
require 'calculations/bicameral_both_houses_sitting'
require 'calculations/bicameral_si_either_house_sitting'
require 'calculations/commons_only_si'
require 'calculations/pnsi'
require 'calculations/treaty'

# ## The controller itself.
class CalculatorController < ApplicationController
  
  # Include code from each of the modules for the different styles of calculation.
  include CALCULATION_BICAMERAL_BOTH_HOUSES_SITTING
  include CALCULATION_BICAMERAL_SI_EITHER_HOUSE_SITTING
  include CALCULATION_COMMONS_ONLY_SI
  include CALCULATION_PNSI
  include CALCULATION_TREATY
  
  # ### This is the code to provide information for the form that users can fill in.
  def index
    
    # Set a title for the page.
    @title = "Calculate scrutiny periods"
    
    # Find all the active procedures in display order - to populate the procedure radio buttons on the form.
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
  
  # ### When the user has pressed 'Calculate', this code runs the calculation.
  def calculate
    
    # Set a title for the page.
	  @title = "Calculated scrutiny period"
    
    # In order to calculate the scrutiny period, we need:
    
	  # * the **type of the procedure** itself, which we refer to by a number
    procedure = params['procedure'].to_i if params['procedure']
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params['start-date']
    
    # * the **day count**
    day_count = params['day-count']
    
    # Check that all the parameters have been provided by the form ...
    if start_date.blank? or day_count.blank? or day_count.to_i == 0 or procedure.nil?
      
      # ... if not, set an error message ...
	    @title = "Sorry, there was not enough information provided."
      
      # ... and display the error.
      render :template => 'calculator/not_enough_information'
      
    # If the form did provide all the required information, do the calculation:
    else
      
      # * find the procedure
      @procedure = Procedure.find( procedure )
      
      # * the **number of days** to count
      @day_count = day_count.to_i
      
      # * make the text of the date passed into a date format
      @start_date = Date.parse( start_date )
      
      # To calculate the **anticipated end date**, we select the calculation based on the type of procedure:
      case @procedure.id
        
      # * Commons and Lords affirmative Statutory Instrument where both Houses are sitting, Legislative Reform Orders, Public Body Orders and Localism Orders
      when 1, 2, 4, 8
        
        @start_date_type = "laying date"
        @end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
        
      # * Proposed Statutory Instrument (PNSI)
      when 3
        
        @start_date_type = "laying date"
        @end_date = pnsi_calculation( @start_date, @day_count )
        
      # * Commons only negative Statutory Instrument and some made affirmatives
      when 5, 7
        
        @start_date_type = "laying date"
        @end_date = commons_only_si_calculation( @start_date, @day_count )
        
      # * Commons and Lords negative Statutory Instrument or a Commons and Lords affirmative Statutory Instrument where either House is sitting
      when 6, 9
        
        @start_date_type = "laying date"
        @end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
        
        # * Treaty period A
      when 10
        
        @start_date_type = "laying date"
        @end_date = treaty_calculation( @start_date, @day_count )
        
        # * Treaty period B
      when 11
        
        @start_date_type = "date of Ministerial statement"
        @end_date = treaty_calculation( @start_date, @day_count )
        
      # * Otherwise set an error message.
      else
        @error_message = "Sorry, this procedure is not currently supported."
      end
    end
  end
end