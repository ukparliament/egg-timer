# # Calculator controller to build the scrutiny period form and run the calculations.
class CalculatorController < ApplicationController
  
  # Include code from each of the modules for the different styles of calculation.
  include Calculations::BicameralBothHousesSitting
  include Calculations::BicameralSiEitherHouseSitting
  include Calculations::CommonsOnlySi
  include Calculations::CommonsOnlySittingDays
  include Calculations::Pnsi
  include Calculations::Treaty
  include Calculations::PnsiReverse
  include Calculations::TreatyReverse
  include Calculations::CommonsOnlySittingDaysReverse
  
  # ### This is the code to provide a list of calculators.
  def index
    
    # We set the meta information for the page.
    @page_title = "Calculators"
    @description = "Calculators made available by #{$SITE_TITLE}."
    @crumb << { label: 'Calculators', url: nil }
    @section = 'calculators'
  end
  
  # ### This is the code to provide information for the form that users can fill in to calculate the end date of a scrutiny period by procedure.
  def scrutiny_period
    
    # We find all the active procedures in display order - to populate the procedure radio buttons on the form.
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc' )
    
    # We set the meta information for the page.
    @page_title = "Scrutiny end date calculator"
    @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date</span>".html_safe
    @description = "A calculator to determine the estimated end date of scrutiny for instruments before Parliament."
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @crumb << { label: 'Scrutiny end date', url: nil }
    @section = 'calculators'
    @subsection = 'scrutiny-calculator'
  end
  
  # ### This is the code to provide information for the form that users can fill in to calculate the start date of a scrutiny period by procedure.
  def reverse_scrutiny_period
    
    # We find all the active procedures in display order - to populate the procedure radio buttons on the form.
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc' )
    
    # We set the meta information for the page.
    @page_title = "Scrutiny start date calculator"
    @multiline_page_title = "Calculators <span class='subhead'>Scrutiny start date</span>".html_safe
    @description = "A calculator to determine the estimated start date of scrutiny for instruments before Parliament."
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @crumb << { label: 'Scrutiny start date', url: nil }
    @section = 'calculators'
    @subsection = 'scrutiny-calculator-reverse'
  end
  
  # ### This is the code to provide information for the form that users wishing to run a specific calculation style can fill in.
  def style
  
    # We get the calculation style if it's been passed as a parameter.
    calculation_style = params['calculation-style']
    @calculation_style = calculation_style.to_i if calculation_style
    
    # We set the meta information for the page.
    @page_title = "Scrutiny end date calculator for a calculation style"
    @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date for a calculation style</span>".html_safe
    @description = "A calculator to determine the estimated end date of scrutiny for instruments before Parliament for a given calculation style."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Scrutiny period calculator by calculation style', url: nil }
  end
  
  # ### This code runs the scrutiny period calculation.
  def calculate
    
    # In order to calculate the anticipated end date of the scrutiny period for a forward calculation or the start date of the scrutiny period for a reverse calculation, we need:
    
    # * the **start date**, for example: "2020-05-06"
    # Note that this is the start date of the calculation. For a reverse calculation, this will be the end date of the scrutiny period.
    start_date = params['start-date']
    
    # * the **day count** and
    day_count = params['day-count']
    
	  # * either the **type of the procedure**, which we refer to by a number
    procedure = params['procedure']
    
    # * or the **calculation style**, which we also refer to by a number
    calculation_style = params['calculation-style']
    
    # Optionally, we may have been passed a direction parameter.
    # This is populated with 'reverse' if we intend the calculation to return an anticipated start date given an end date.
    direction = params['direction']
    @direction = direction
    
    # Calling this method also sets instance variables for start date, day count, procedure and calculation style.
    # If we don't have enough information to proceed with the calculation ...
    unless calculation_can_proceed?( start_date, day_count, procedure, calculation_style )
    
      # ... we call the insufficient information method.
      insufficient_information
      
    # Otherwise, if we do have enough information to proceed with the calculation ...
    else
      
      # ... if the day count has not been provided or the day count is invalid ...
      if !@day_count or is_day_count_invalid?( @day_count )
      
        # We set generic meta information for both forward and reverse calculations.
        @crumb << { label: 'Calculators', url: calculator_list_url }
        @section = 'calculators'
      
        # If the direction of the calculation is reverse ...
        if @direction == 'reverse'

          # ... we set the meta information for the page ...
          @page_title = "Scrutiny start date - number of days to count required"
          @multiline_page_title = "Calculators <span class='subhead'>Scrutiny start date - number of days to count required</span>".html_safe
          @description = "Number of days to count required for a calculation to determine the estimated start date of scrutiny for instruments before Parliament."
          @crumb << { label: 'Scrutiny start date', url: reverse_calculator_form_url }
          @subsection = 'scrutiny-calculator-reverse'
          
        # Otherwise, if the direction of calculation is not reverse ...
        else

          # ... we set the meta information for the page ...
          @page_title = "Scrutiny end date - number of days to count required"
          @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date - number of days to count required</span>".html_safe
          @description = "Number of days to count required for a calculation to determine the estimated end date of scrutiny for instruments before Parliament."
          @crumb << { label: 'Scrutiny end date', url: calculator_form_url }
          @crumb << { label: 'Number of days to count required', url: nil }
          @subsection = 'scrutiny-calculator'
        end
        @crumb << { label: 'Number of days to count required', url: nil }

        # ... and we render the day count form.
        render :template => 'calculator/day_count_form'
        
      # Otherwise, if the day count has been provided and the day count is not invalid ...
      else

        # If the procedure has been passed as a parameter ...
        if @procedure
  
          # ... to calculate the **anticipated end date**, we select the calculation based on the type of procedure:
          case @procedure.id

            # * Legislative Reform Orders, Public Body Orders, Localism Orders and enhanced affirmatives under the Investigatory Powers Act 2016
            when 1, 17, 18, 19, 2, 4, 21, 22, 23

              @start_date_type = "laying date"
              @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )

            # * Proposed Statutory Instruments (PNSIs)
            when 3
            
              if @direction == 'reverse'
                @scrutiny_end_date = pnsi_calculation_reverse( @start_date, @day_count )
                @message = "In order to meet the target end date, the instrument must be <em>laid earlier than</em> the anticipated start date of the scrutiny period."
              else
                @scrutiny_end_date = pnsi_calculation( @start_date, @day_count )
                @start_date_type = "laying date"
              end

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
            
              if @direction == 'reverse'
                @scrutiny_end_date = treaty_calculation_reverse( @start_date, @day_count )
                @message = "In order to meet the target end date, the treaty must be <em>laid earlier than</em> the anticipated start date of the scrutiny period."
              else
                @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
                @start_date_type = "laying date"
              end
              
            # * Treaty period B
            when 11
            
              if @direction == 'reverse'
                @scrutiny_end_date = treaty_calculation_reverse( @start_date, @day_count )
                @message = "In order to meet the target end date, the ministerial statement must be <em>made earlier than</em> the anticipated start date of the scrutiny period."
              else
                @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
                @start_date_type = "date of Ministerial statement"
              end

            # * Published drafts under the European Union (Withdrawal) Act 2018
            when 12
  
              @start_date_type = "date of publication"
              @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
    
            # * National Policy Statements.
            when 20
            
              if @direction == 'reverse'
                @scrutiny_end_date = commons_only_sitting_days_reverse( @start_date, @day_count )
                @message = "In order to meet the target end date, the national policy statement must be <em>laid earlier than</em> the anticipated start date of the scrutiny period."
             else
                @scrutiny_end_date = commons_only_sitting_days( @start_date, @day_count )
                @start_date_type = "laying date"
              end
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
            else

              # ... we add a reason to the missing information array ...
              @missing_information << 'a valid calculation style'
    
              # ... and call the insufficient information method.
              insufficient_information
          end
        end
        # We set the generic meta information.
        @json_url = request.original_fullpath.sub '?', '.json?'
        @crumb << { label: 'Calculators', url: calculator_list_url }
        @section = 'calculators'
      
        # If the direction of the calculation is reverse ...
        if @direction == 'reverse'
      
          # ... we set the meta information for the page.
          @page_title = "Scrutiny start date calculation"
          @multiline_page_title = "Calculators <span class='subhead'>Scrutiny start date calculation</span>".html_safe
          @description = "A calculation to determine the estimated start date of scrutiny for instruments before Parliament."
          @calendar_links << ['Anticipated start date of the scrutiny period', request.original_fullpath.sub( '?', '.ics?' )]
          @crumb << { label: 'Scrutiny start date', url: reverse_calculator_form_url }
          @crumb << { label: 'Calculation', url: nil }
          @subsection = 'scrutiny-calculator-reverse'
        
          render :template => 'calculator/scrutiny_reverse'
      
        # Otherwise, if the direction of the calculation is not reverse ...
        else
      
          #  .. we set the meta information for the page.
          @page_title = "Scrutiny end date calculation"
          @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date calculation</span>".html_safe
          @description = "A calculation to determine the anticipated end date of scrutiny for instruments before Parliament."
          @json_url = request.original_fullpath.sub '?', '.json?'
          @calendar_links << ['Anticipated end date of the scrutiny period', request.original_fullpath.sub( '?', '.ics?' )]
          @crumb << { label: 'Scrutiny end date', url: calculator_form_url }
          @crumb << { label: 'Calculation', url: nil }
          @subsection = 'scrutiny-calculator'
        end
      end
    end
  end
  
  # ### A method to check if the scrutiny period calculation can proceed.
  # This method also creates the start date, day count, procedure and calculation style as instance variables.
  def calculation_can_proceed?( start_date, day_count, procedure, calculation_style )
  
    # We create a variable to hold a boolean, determining if the scrutiny period calculation can proceed. 
    calculation_can_proceed = true
  
    # We create an array to hold any errors we find as a result of missing information.
    @missing_information = []
    
    # ## We check for the presence of a valid start date.
    # If the start date is present ...
    if start_date
    
      # ... we attempt to convert the start date string into a date, storing the result as a instance variable.
      begin
         @start_date = Date.parse( start_date )
  
      # If the start date string cannot be converted into a date ...
      rescue ArgumentError
    
        # ... we flag that the calculation cannot proceed ...
        calculation_can_proceed = false
     
        # ... and add a reason to the missing information array.
        @missing_information << invalid_date_type_label
      end
    
    # Otherwise, if the start date is not present ...
    else
    
      # ... we flag that the calculation cannot proceed ...
      calculation_can_proceed = false
     
      # ... and add a reason to the missing information array.
      @missing_information << missing_date_type_label
    end
    
    # ## We check for the presence of a valid day count.
    # If a day count has been passed ...
    if day_count
      
      # ... we convert the day count to an integer, storing the result as a instance variable.
      @day_count = day_count.to_i
  
      # If the day count is an invalid day count ...
      if is_day_count_invalid?( @day_count )
    
        # ... we do not flag that the calculation cannot proceed because this will be picked up by the day count form.
  
        # We add a reason to the missing information array.
        @missing_information << 'a valid day count'
      end
      
    # Otherwise, if a day count has not been passed ...
    else
    
      # ... we do not flag that the calculation cannot proceed because this will be picked up by the day count form.
    
      # We add a reason to the missing information array.
      @missing_information << 'a day count'
    end
    
    # ## We check for the presence of a valid procedure *or* a valid calculation style.
    # If the calculation has been passed neither a procedure, nor a calculation style ...
    if !procedure and !calculation_style
      
      # ... we flag that the calculation cannot proceed ...
      calculation_can_proceed = false
      
      # ... and add a reason to the missing information array.
      @missing_information << 'a procedure or calculation style'
      
    # Otherwise, if the calculation has been passed a procedure ...
    elsif procedure
    
      # ... we attempt to find the procedure, storing the result as a instance variable.
      @procedure = Procedure.find_by_id( procedure )
        
      # If we fail to find the procedure ...  
      unless @procedure
    
        # ... we flag that the calculation cannot proceed ...
        calculation_can_proceed = false
    
        # ... and add a reason to the missing information array.
        @missing_information << 'a valid procedure'
      end
      
    # Otherwise, if the calculation has been passed a calculation style ...
    elsif calculation_style
    
      # ... we convert the calculation style ID to an integer, storing the result as a instance variable.
      @calculation_style = calculation_style.to_i
      
      # If the calculation style is an invalid calculation style ...
      if is_calculation_style_invalid?( @calculation_style )
      
        # ... we flag that the calculation cannot proceed ...
        calculation_can_proceed = false
      
        # ... and add a reason to the missing information array.
        @missing_information << 'a valid calculation style'
      end
    end
    
    # We return the calculation can proceed boolean.
    calculation_can_proceed
  end
  
  # ### A method to check if the day count is valid.
  def is_day_count_valid?( day_count )
  
    # We create a boolean to hold the validity of the day count.
    is_day_count_valid = true
    
    # If the day count is zero or a negative number ...
    if day_count == 0 or day_count.negative?
    
      # ... we set the is day count valid boolean to false.
      is_day_count_valid = false
    end
    
    # We return the is day count valid boolean.
    is_day_count_valid
  end
  
  # ### A method to check if the day count is invalid.
  def is_day_count_invalid?( day_count )
  
    # We flip the boolean returned by the is day count valid method.
    !is_day_count_valid?( day_count )
  end
  
  # ### A method to check if the calculation style is valid.
  def is_calculation_style_valid?( calculation_style )
  
    # We create a boolean to hold the validity of the calculation style.
    is_calculation_style_valid = true
    
    # If the calculation style is zero or a negative number ...
    if calculation_style == 0 or calculation_style.negative?
    
      # ... we set the is calculation style valid boolean to false.
      is_calculation_style_valid = false
    end
    
    # We return the is calculation style valid boolean.
    is_calculation_style_valid
  end
  
  # ### A method to check if the calculation style is invalid.
  def is_calculation_style_invalid?( calculation_style )
  
    # We flip the boolean returned by the is calculation style valid method.
    !is_calculation_style_valid?( calculation_style )
  end
  
  # ### A method to report that we have insufficient information for the scrutiny period calculation to proceed.
  def insufficient_information
  
    # We set the generic meta information.
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @section = 'calculators'
  
    # If the calculation is a reverse calculation ...
    if @direction == 'reverse'

      # ... we set the meta information for the page ...
      @page_title = "Scrutiny start date - more information required"
      @multiline_page_title = "Calculators <span class='subhead'>Scrutiny start date - more information required</span>".html_safe
      @description = "More information required for a calculation to determine the estimated start date of scrutiny for instruments before Parliament."
      @crumb << { label: 'Scrutiny start date', url: reverse_calculator_form_url }
      @subsection = 'scrutiny-calculator-reverse'
      
    # Otherwise, if the calculation is not a reverse calculation ...
    else

      # ... we set the meta information for the page ...
      @page_title = "Scrutiny end date - more information required"
      @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date - more information required</span>".html_safe
      @description = "More information required for a calculation to determine the estimated end date of scrutiny for instruments before Parliament."
      @crumb << { label: 'Scrutiny end date', url: calculator_form_url }
      @subsection = 'scrutiny-calculator'
    end
    
    # We set more generic meta information.
    @crumb << { label: 'More information required', url: nil }
    
    # We display the not enough information message.
    render :template => 'calculator/not_enough_information'
  end
  
  # ### A method to return the label of any missing date type.
  # For the end date scrutiny period calculator, this will be the start date.
  # For the start date scrutiny period calculator, this will be the end date. 
  def missing_date_type_label
  
    # If the calculation is a reverse calculation, calculating a start date ...
    if @direction == 'reverse'
    
      # ... the missing date parameter is an end date.
      'an end date'
      
    # Otherwise, if the calculation is a forward calculation, calculating an end date ...
    else
  
      # ... the missing date parameter is a start date.
      'a start date'
    end
  end
  
  # ### A method to return the label of any invalid date type.
  # For the end date scrutiny period calculator, this will be the start date.
  # For the start date scrutiny period calculator, this will be the end date. 
  def invalid_date_type_label
  
    # If the calculation is a reverse calculation, calculating a start date ...
    if @direction == 'reverse'
    
      # ... the missing date parameter is an end date.
      'a valid end date'
      
    # Otherwise, if the calculation is a forward calculation, calculating an end date ...
    else
  
      # ... the missing date parameter is a start date.
      'a valid start date'
    end
  end
end