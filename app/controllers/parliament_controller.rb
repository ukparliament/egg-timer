class ParliamentController < ApplicationController
  
  def index
    @parliaments = ParliamentPeriod.all.order( 'number desc' )
    @title = "Parliament periods"
  end
  
  def show
    parliament = params[:parliament]
    @parliament = ParliamentPeriod.find( parliament )
    @title = @parliament.label
    
    # We get all the periods in this Parliament, being sessions and prorogations.
    @in_parliament_periods = @parliament.in_parliament_periods
  end
end
