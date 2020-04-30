class ProrogationPeriodController < ApplicationController
  
  def index
    @prorogation_periods = ProrogationPeriod.all.order( 'start_on desc' )
  end
  
  def show
    prorogation_period = params[:prorogation_period]
    @prorogation_period = ProrogationPeriod.find( prorogation_period )
  end
end
