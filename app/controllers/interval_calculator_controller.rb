class IntervalCalculatorController < ApplicationController
  
  # We include code from the interval calculation module.
  include Calculations::Interval

  # ### This is the code to build the interval calculation form.
  def form
    @page_title = "Sitting days during an interval calculator"
    @multiline_page_title = "Calculators <span class='subhead'>Sitting days during an interval</span>".html_safe
    @description = "A calculator to determine the number of sitting days for both Houses during an interval."
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @crumb << { label: 'Sitting days during an interval', url: nil }
    @section = 'calculators'
    @subsection = 'interval-calculator'
  end
  
  # ### This is the code to calculate the number of sitting days during an interval of time.
  def calculate
    
    # In order to calculate the number of sitting days during an interval, we need:
    
    # * the **start date**, for example: "2020-05-06"
    start_date = params['start-date']
    
    # * the **end date**, for example: "2021-04-11"
    end_date = params['end-date']
    
    # If we have not been passed all the parameters to enable the calculation to proceed ...
    unless calculation_can_proceed?( start_date, end_date )
    
      # ... we call the insufficient information method.
      insufficient_information
      
    # Otherwise, if we have been passed all the parameters to enable the calculation to proceed ...
    else
      
      # We pass the text of the start date and end date into date formats.
      @start_date = Date.parse( start_date )
      @end_date = Date.parse( end_date )
      
      # If the start date is the same as or after the end date ...
      if @start_date >= @end_date
      
        # We add a reason to the missing information array ...
        @missing_information << 'the start date to precede the end date'
    
        # ... and call the insufficient information method. 
        insufficient_information
        
      # Otherwise, if the end date is after the start date ...
      else
        
        # ... we set the sitting day counts ...
        @commons_sitting_day_count = 0
        @lords_sitting_day_count = 0
        
        # ... calculate the sitting days in the interval ...
        calculate_sitting_days_in_interval( @start_date, @end_date )
        
        # ... and set a meta information for the page.
        @page_title = "Sitting days during an interval calculation"
        @multiline_page_title = "Calculators <span class='subhead'>Sitting days during an interval calculation</span>".html_safe
        @description = "A calculation to determine the number of sitting days in both Houses during an interval."
        @crumb << { label: 'Calculators', url: calculator_list_url }
        @crumb << { label: 'Sitting days during an interval', url: calculator_interval_url }
        @crumb << { label: 'Calculation', url: nil }
        @section = 'calculators'
        @subsection = 'interval-calculator'
      end
    end
  end
  
  # ### A method to check if the interval calculation can proceed.
  def calculation_can_proceed?( start_date, end_date )
  
    # We create a variable to hold a boolean, determining if the interval calculation can proceed.
    calculation_can_proceed = true
  
    # We create an array to hold any errors we find as a result of missing information.
    @missing_information = []
    
    # If the start date is present ...
    if start_date
    
      # We attempt to parse the start date as date.
      begin
         Date.parse( start_date )
  
      # If parsing the start date as a date fails ...
      rescue ArgumentError
    
        # ... we flag that the calculation cannot proceed ...
        calculation_can_proceed = false
     
        # ... and add a reason to the missing information array.
        @missing_information << 'a valid start date'
      end
    
    # Otherwise, if the start date is not present ...
    else
    
      # ... we flag that the calculation cannot proceed ...
      calculation_can_proceed = false
     
      # ... and add a reason to the missing information array.
      @missing_information << 'a start date' 
    end
    
    # If the end date is present ...
    if end_date
    
      # We attempt to parse the end date as a date.
      begin
         Date.parse( end_date )
  
      # If parsing the end date as a date fails ...
      rescue ArgumentError
    
        # ... we flag that the calculation cannot proceed ...
        calculation_can_proceed = false
     
        # ... and add a reason to the missing information array.
        @missing_information << 'a valid end date'
      end
    
    # Otherwise, if the end date is not present ...
    else
    
      # ... we flag that the calculation cannot proceed ...
      calculation_can_proceed = false
     
      # ... and add a reason to the missing information array.
      @missing_information << 'an end date' 
    end
    
    # We return the calculation can proceed boolean.
    calculation_can_proceed
  end
  
  
  # ### A method to report that we have insufficient information for the interval calculation to proceed.
  def insufficient_information
  
    # We set the meta information for the page ...
    @page_title = "Sitting days during an interval - more information required"
    @multiline_page_title = "Calculators <span class='subhead'>Sitting days during an interval - more information required</span>".html_safe
    @description = "More information required for a calculation to determine the number of sitting days in both Houses during an interval."
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @crumb << { label: 'Sitting days during an interval', url: calculator_interval_url }
    @crumb << { label: 'More information required', url: nil }
    @section = 'calculators'
    @subsection = 'interval-calculator'

    # ... and display the not enough information message.
    render :template => 'interval_calculator/not_enough_information'
  end
end
