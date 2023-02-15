# Calculator controller to build the form and run the calculations.

Individual calculations for different flavours of instrument are packaged into separate files. This code requires those files to be loaded.

require 'calculations/bicameral_both_houses_sitting'
require 'calculations/bicameral_si_either_house_sitting'
require 'calculations/commons_only_si'
require 'calculations/pnsi'
require 'calculations/treaty'
## The controller itself.

class CalculatorController < ApplicationController
Include code from each of the modules for the different styles of calculation.

  include CALCULATION_BICAMERAL_BOTH_HOUSES_SITTING
  include CALCULATION_BICAMERAL_SI_EITHER_HOUSE_SITTING
  include CALCULATION_COMMONS_ONLY_SI
  include CALCULATION_PNSI
  include CALCULATION_TREATY
### This is the code to provide information for the form that users can fill in.

  def index
Set a title for the page.

    @title = "Calculate scrutiny periods"
Find all the active procedures in display order - to populate the procedure radio buttons on the form.

    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
### This code runs the calculation.

  def calculate
In order to calculate the scrutiny period, we need:

* the **type of the procedure** itself, which we refer to by a number

    procedure = params['procedure'].to_i if params['procedure']
* the **start date**, for example: "2020-05-06"

    start_date = params['start-date']
* the **day count**

    day_count = params['day-count']
If the procedure and the start date have not been provided by the initial form ...

    if start_date.blank? or procedure.nil?
... we set an error message ...

	    @title = "Sorry, there was not enough information provided."
... and display the error.

      render :template => 'calculator/not_enough_information'
If the **procedure** and the **start date** have been provided by the initial form, we ...

    else
# * find the procedure

      @procedure = Procedure.find( procedure )
* make the text of the date passed into a date format

      @start_date = Date.parse( start_date )
If the day count has not been provided by the day count form or the day count is 0 ...

      if day_count.blank? or day_count.to_i == 0
... we set a title for the page.

    	  @title = "Calculate scrutiny period"
We render the day count form.

        render :template => 'calculator/day_count_form'
If the day count has been provided by the day count form ...

      else
... we set a title for the page.

    	  @title = "Calculated scrutiny period"
We get the day count as an integer.

        @day_count = day_count.to_i
To calculate the **anticipated end date**, we select the calculation based on the type of procedure:

        case @procedure.id
* Legislative Reform Orders, Public Body Orders and Localism Orders

        when 1, 17, 18, 19, 2, 4
          @start_date_type = "laying date"
          @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
* Proposed Statutory Instruments (PNSIs)

        when 3
          @start_date_type = "laying date"
          @scrutiny_end_date = pnsi_calculation( @start_date, @day_count )
* Commons only negative Statutory Instruments

        when 5
          @start_date_type = "laying date"
          @scrutiny_end_date = commons_only_si_calculation( @start_date, @day_count )
* Commons and Lords negative Statutory Instruments and proposed and draft affirmative remedial orders

        when 6, 13, 14
          @start_date_type = "laying date"
          @scrutiny_end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
* Some Commons only made affirmative Statutory Instruments

        when 7
          @start_date_type = "making date"
          @scrutiny_end_date = commons_only_si_calculation( @start_date, @day_count )
* Commons and Lords made affirmative Statutory Instruments where both Houses are sitting

        when 8
          @start_date_type = "making date"
          @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
* Commons and Lords made affirmative Statutory Instruments where either House is sitting and made affirmative remedial orders

        when 9, 15, 16
          @start_date_type = "making date"
          @scrutiny_end_date = bicameral_si_either_house_sitting_calculation( @start_date, @day_count )
* Treaty period A

        when 10
          @start_date_type = "laying date"
          @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
* Treaty period B

        when 11
          @start_date_type = "date of Ministerial statement"
          @scrutiny_end_date = treaty_calculation( @start_date, @day_count )
* Published drafts under the European Union (Withdrawal) Act 2018

        when 12
          @start_date_type = "date of publication"
          @scrutiny_end_date = bicameral_calculation_both_houses_sitting( @start_date, @day_count )
        end
      end
    end
  end
end
