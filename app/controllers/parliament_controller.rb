class ParliamentController < ApplicationController
  
  def index
    @parliaments = ParliamentPeriod.all.order( 'number desc' )
  end
  
  def show
    parliament = params[:parliament]
    @parliament = ParliamentPeriod.find( parliament )
  end
end
