class DissolutionPeriodController < ApplicationController
  
  def index
    @dissolution_periods = DissolutionPeriod.all.order( 'number desc' )
  end
  
  def show
    dissolution_period = params[:dissolution_period]
    @dissolution_period = DissolutionPeriod.find( dissolution_period )
  end
end
