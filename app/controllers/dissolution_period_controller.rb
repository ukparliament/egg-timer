class DissolutionPeriodController < ApplicationController
  
  def index
    @dissolution_periods = DissolutionPeriod.all.order( 'number desc' )
    @title = "Dissolution periods"
  end
  
  def show
    dissolution_period = params[:dissolution_period]
    @dissolution_period = DissolutionPeriod.find( dissolution_period )
    @title = @dissolution_period.label
  end
end
