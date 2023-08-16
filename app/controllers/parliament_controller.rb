class ParliamentController < ApplicationController
  
  def index
    @parliaments = ParliamentPeriod.all.order( 'number desc' )
    @title = "Parliament periods"
  end
  
  def show
    parliament = params[:parliament]
    @parliament = ParliamentPeriod.find( parliament )
    @title = @parliament.label
    
    # We construct a time periods array to store both sessions and prorogation periods.
    @time_periods = []
    @parliament.sessions.each do |session|
      time_period =[]
      time_period[0] = 'Session'
      time_period[1]= session.start_date
      time_period[2] = session
      @time_periods << time_period
    end
    @parliament.prorogation_periods.each do |prorogation_period|
      time_period =[]
      time_period[0] = 'Prorogation'
      time_period[1]= prorogation_period.start_date
      time_period[2] = prorogation_period
      @time_periods << time_period
    end
    
    # We sort the time periods array by start date.
    @time_periods.sort_by!{ |tp| tp[1] }
  end
end
