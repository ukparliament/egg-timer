class ProrogationPeriodController < ApplicationController
  
  def index
    @prorogation_periods = ProrogationPeriod.all.order( 'start_date desc' )
    @title = "Prorogation periods"

    # Set a meta information for the page.
    @page_title = "Prorogation periods"
    @description = "Prorogation periods."
    @csv_url = prorogation_period_list_url( :format => 'csv' )
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Prorogation periods', url: nil }
    @section = 'time-periods'
  end
  
  def show
    prorogation_period = params[:prorogation_period]
    @prorogation_period = ProrogationPeriod.find_by_sql(
      [
      "
        SELECT pp.*, parl.number AS parliament_number
        FROM prorogation_periods pp, parliament_periods parl
        WHERE pp.id = ?
        AND pp.parliament_period_id = parl.id
      ", prorogation_period
      ]
    ).first

    # Alt implementation
    # ProrogationPeriod.joins(:parliament_period).find(prorogation_period)
    @title = @prorogation_period.label_with_parliament
    @preceding_session = @prorogation_period.preceding_session
    @following_session = @prorogation_period.following_session

    # Set a meta information for the page.
    @page_title = @prorogation_period.label_with_parliament
    @description = "#{@prorogation_period.label_with_parliament}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Parliament periods', url: parliament_list_url }
    @crumb << { label: @prorogation_period.parliament_label, url: parliament_show_url( :parliament => @prorogation_period.parliament_period_id )}
    @crumb << { label: @prorogation_period.label_in_parliament, url: nil }
    @section = 'time-periods'
  end
end
