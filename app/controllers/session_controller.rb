class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_on desc' )
  end
  
  def show
    session = params[:session]
    @session = Session.find( session )
  end
end
