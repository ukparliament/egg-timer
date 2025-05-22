# # Calculator controller to build the form and run the calculations.

# Individual calculations for different flavours of instrument are packaged into separate files. This code requires those files to be loaded.
# require 'bicameral_si_either_house_sitting'
# require 'commons_only_si'
# require 'commons_only_sitting_days'
# require 'pnsi'
# require 'treaty'
# require 'interval'

# ## The controller itself.
class CalculatorController < ApplicationController
  
  # Include code from each of the modules for the different styles of calculation.
  include Calculations::BicameralBothHousesSitting
  include Calculations::BicameralSiEitherHouseSitting
  include Calculations::CommonsOnlySi
  include Calculations::CommonsOnlySittingDays
  include Calculations::Pnsi
  include Calculations::Treaty
  include Calculations::Interval
  
  # ### This is the code to provide a list of calculators.
  def index
    
    # Set a meta information for the page.
    @page_title = "Calculators"
    @description = "Calculators made available by #{$SITE_TITLE}."
    @crumb << { label: 'Calculators', url: nil }
    @section = 'calculators'
  end
  
  # ### This is the code to provide information for the form that users can fill in.
  def scrutiny_period
    
    # Set a title for the page.
    @title = "Calculate scrutiny periods"
    
    # Find all the active procedures in display order - to populate the procedure radio buttons on the form.
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
  
  # ### This is the code to provide information for the form that users wishing to run a specific calculation style can fill in.
  def style
  
    # We get the calculation style if it's been passed as a parameter.
    calculation_style = params['calculation-style']
    @calculation_style = calculation_style.to_i if calculation_style
    
    # Set a title for the page.
    @title = "Calculate scrutiny periods"
  end
  
  # ### This code runs the calculation.
  def calculate
    
    # In order to calculate the scrutiny period, we need:
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params['start-date']
    
    # * the **day count** and
    day_count = params['day-count']
    
	  # * either the **type of the procedure** itself, which we refer to by a number
    procedure = params['procedure'].to_i if params['procedure']
    
    # * or the **calculation style**, which we also refer to by a number
    calculation_style = params['calculation-style'].to_i if params['calculation-style']
    
    # If neither the **procedure**  nor the **calculation style** have been provided, or the **start date** has not been provided ...
    if ( procedure.nil? and calculation_style.nil? ) or start_date.blank?
      
      # ... we set an error message ...
	    @title = "Sorry, we need more information to complete the calculation"
      
      # ... and display the error.
      render :template => 'calculator/not_enough_information'
      
    # If the **start date** and either the **procedure** or the **calculation style** have been provided by the initial form, we ...
    else
      
      # * make the text of the date passed into a date format
      @start_date = Date.parse( start_date )
      
      # # * find the procedure if there is one
      @procedure = Procedure.find( procedure ) if procedure
      
      # # * set the calculation style if there is one
      @calculation_style = calculation_style if calculation_style
      
      # If the day count has not been provided by the day count form or the day count is 0 ...
      if day_count.blank? or day_count.to_i == 0
    
        # ... we set a title for the page.
    	  @title = "Calculate scrutiny period"
        
        # We render the day count form.
        render :template => 'calculator/day_count_form'
        
      # If the day count has been provided by the day count form ...
      else
        
        # ... we set a title for the page.
    	  @title = "Calculated scrutiny period"
        
        # We get the day count as an integer.
        @day_count = day_count.to_i
        
        # If the procedure has been selected ...
        if @procedure
          
          # To calculate the **anticipated end date**, we select the calculation based on the type of procedure:
          case @procedure.id
        
          # * Legislative Reform Orders, Public Body Orders, Localism Orders and enhanced affirmatives under the Investigatory Powers Act 2016
          when 1, 17, 18, 19, 2, 4, 21, 22, 23
        
            @start_date_type = "laying date"
            @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
        
          # * Proposed Statutory Instruments (PNSIs)
          when 3
        
            @start_date_type = "laying date"
            @scrutiny_end_date = pnsi_calculation( @start_date, @day_count )
        
          # * Commons only negative Statutory Instruments
          when 5
        
            @start_date_type = "laying date"
            @scrutiny_end_date = commons_only_si_calculation( @start_date, @day_count )
        
          # * Commons and Lords negative Statutory Instruments, proposed and draft affirmative remedial orders
          when 6, 13, 14
      
            @start_date_type = "laying date"
            @scrutiny_end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
        
          # * Some Commons only made affirmative Statutory Instruments
          when 7
      
            @start_date_type = "making date"
            @scrutiny_end_date = commons_only_si_calculation( @start_date, @day_count )
        
          # * Commons and Lords made affirmative Statutory Instruments where both Houses are sitting
          when 8
        
            @start_date_type = "making date"
            @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
        
          # * Commons and Lords made affirmative Statutory Instruments where either House is sitting and made affirmative remedial orders
          when 9, 15, 16
      
            @start_date_type = "making date"
            @scrutiny_end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
        
          # * Treaty period A
          when 10
        
            @start_date_type = "laying date"
            @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
        
          # * Treaty period B
          when 11
        
            @start_date_type = "date of Ministerial statement"
            @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
        
          # * Published drafts under the European Union (Withdrawal) Act 2018
          when 12
          
            @start_date_type = "date of publication"
            @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
            
          # * National Policy Statements.
          when 20
            
            @start_date_type = "laying date"
            @scrutiny_end_date = commons_only_sitting_days( @start_date, @day_count )
          end
          
        # Otherwise, if the calculation style has been selected ...
        elsif @calculation_style
          
          # ... to calculate the **anticipated end date**, we select the calculation based on the calculation style:
          case @calculation_style
        
          # * Calculation style 1
          when 1
            
            @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
          
          # * Calculation style 2
          when 2
            
            @scrutiny_end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
          
          # * Calculation style 3
          when 3
            
            @scrutiny_end_date = commons_only_si_calculation( @start_date, @day_count )
          
          # * Calculation style 4
          when 4
            
            @scrutiny_end_date = pnsi_calculation( @start_date, @day_count )
          
          # * Calculation style 5
          when 5
            
            @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
          
          # * Calculation style 6
          when 6
            
            @scrutiny_end_date = commons_only_sitting_days( @start_date, @day_count )
          end
        end
      end
      @alternate_title = 'anticipated end date of the scrutiny period'
      @json_url = request.original_fullpath.sub '?', '.json?'
      @calendar_links = []
      calendar_link = ['Anticipated end date of the scrutiny period', request.original_fullpath.sub( '?', '.ics?' )]
      @calendar_links << calendar_link
    end
  end
  
  # ### This is the code to build the interval calculation form.
  def interval
    

    @title = "Calculate sitting days during an interval"
    
    # We get both Houses.
    @houses = House.all
  end
  
  # ### This is the code to calculate the number of sitting days during an interval of time.
  def interval_calculate
    
    # In order to calculate the number of sitting days during an interval, we need:
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params['start-date']
    
    # * the **end date**, for example: "2021-04-11"
    end_date = params['end-date']
    
    # If neither the **start date** nor the ** end date** has not been provided ...
    if start_date.blank? or end_date.blank?
      
      # ... we set an error message ...
	    @title = "Sorry, we need more information to complete the calculation"
      
      # ... and display the error.
      render :template => 'calculator/interval_not_enough_information'
      
    # Otherwise, if both the start date and the end date have been provided ...
    else
        
      # ... we set a title for the page.
    	@title = "Number of sitting days within the interval"
      
      # We make the text of the start date and end date passed into date formats.
      @start_date = Date.parse( start_date )
      @end_date = Date.parse( end_date )
      
      # If the start date is the same as or after the end date ...
      if @start_date >= @end_date
        
        # ... we set a title for the page ...
    	  @title = "Unable to calculate sitting days"
        
        # ... construct an error mesage.
        @error_message = "The start date must precede the end date."
        
        # ... and display the error.
        render :template => 'calculator/interval_error'
        
      # Otherwise, if the end date is after the start date ...
      else
        
        # ... we set the sitting day counts ...
        @commons_sitting_day_count = 0
        @lords_sitting_day_count = 0
        
        # ... and calculate the sitting days in the interval.
        calculate_sitting_days_in_interval( @start_date, @end_date )
      end
    end
  end
end
    
    
    
    
    
    
    
      
      