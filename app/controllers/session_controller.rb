class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_on desc' )
    @title = "Sessions"
  end
  
  def show
    session = params[:session]
    @session = Session.find( session )
  end
end
