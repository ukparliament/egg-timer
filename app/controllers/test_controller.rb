class TestController < ApplicationController

  def index
    @procedures = Procedure.all.where( 'active is true' ).order( 'display_order asc' )
  end
end
