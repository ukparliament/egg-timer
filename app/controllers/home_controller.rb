class HomeController < ApplicationController
  
  def index
  	@title = "Calculate a scrutiny period"
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc')
  end
end
