class HomeController < ApplicationController
  
  def index
  	@title = "Calculate scrutiny period"
    @procedures = Procedure.all.where( 'active is true' )
  end
end
