class HomeController < ApplicationController
  
  def index
    @page_title = 'Parliamentary time'
    @description = 'A resource for parliamentary time, provided by the Commons Library.'
  end
end
