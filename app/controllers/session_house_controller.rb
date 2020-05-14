class SessionHouseController < ApplicationController
  
  def index
    session = params[:session]
    @session = Session.find( session )
    @houses = House.all
    @title = @session.label_with_parliament + ' - Houses'
  end
  
  def show
    session = params[:session]
    @session = Session.find( session )
    house = params[:house]
    @house = House.find( house )
    @title = @session.label_with_parliament + ' - ' + @house.name
  end
end
