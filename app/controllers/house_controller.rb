class HouseController < ApplicationController
  
  def index
    @houses = House.all
    @title = "Houses"
  end
  
  def show
    house = params[:house]
    @house = House.find( house )
  end
end
