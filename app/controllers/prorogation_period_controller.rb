class ProrogationPeriodController < ApplicationController
  
  def index
    @prorogation_periods = ProrogationPeriod.all.order( 'start_date desc' )
    @title = "Prorogation periods"
  end
  
  def show
    prorogation_period = params[:prorogation_period]
    @prorogation_period = ProrogationPeriod.find( prorogation_period )
    @title = @prorogation_period.label_with_parliament
  end
end
