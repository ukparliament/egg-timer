class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_date desc' )
    @title = "Sessions"
  end
  
  def show
    session = params[:session]
    @session = Session.find( session )
    @houses = House.all
    @title = @session.label_with_parliament
  end
end
