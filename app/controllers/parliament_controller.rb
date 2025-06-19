class ParliamentController < ApplicationController
  
  def index
    @parliaments = ParliamentPeriod.all.order( 'number desc' )
    @title = "Parliament periods"
    
    respond_to do |format|
       format.csv {
         response.headers['Content-Disposition'] = "attachment; filename=\"uk-parliament-parliament-periods.csv\""
       }
       format.html{

        # Set a meta information for the page.
        @page_title = "Parliament periods"
        @description = "Parliament periods."
        @csv_url = parliament_list_url( :format => 'csv' )
        @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
        @crumb << { label: 'Parliament periods', url: nil }
        @section = 'time-periods'
      }
    end
  end
  
  def show
    parliament = params[:parliament]
    @parliament = ParliamentPeriod.find( parliament )
    @title = @parliament.label
    
    # We get all the periods in this Parliament, being sessions and prorogations.
    @in_parliament_periods = @parliament.in_parliament_periods
    
    # Set a meta information for the page.
    @page_title = @parliament.label
    @description = "#{@parliament.label} of the United Kingdom."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Parliament periods', url: parliament_list_url }
    @crumb << { label: @parliament.label, url: nil }
    @section = 'time-periods'
  end
end
