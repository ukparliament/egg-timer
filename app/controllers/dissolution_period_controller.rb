class DissolutionPeriodController < ApplicationController
  
  def index
    @dissolution_periods = DissolutionPeriod.all.order( 'number desc' )

    # Set a meta information for the page.
    @page_title = "Dissolution periods"
    @description = "Dissolution periods."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Dissolution periods', url: nil }
    @section = 'time-periods'
  end
  
  def show
    dissolution_period = params[:dissolution_period]
    @dissolution_period = DissolutionPeriod.find( dissolution_period )

    # Set a meta information for the page.
    @page_title = @dissolution_period.label
    @description = "Dissolution periods."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Dissolution periods', url: dissolution_period_list_url }
    @crumb << { label: @dissolution_period.label, url: nil }
    @section = 'time-periods'
  end
end
