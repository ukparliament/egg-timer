class ProrogationPeriodController < ApplicationController
  
  def index
    @prorogation_periods = ProrogationPeriod.all.order( 'start_date desc' )
    @title = "Prorogation periods"
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
  end
end
