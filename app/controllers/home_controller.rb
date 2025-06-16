class HomeController < ApplicationController
  
  def index
    @page_title = 'Parliamentary time'
    @description = 'The Commons Library resource for parliamentary time.'
  end
end
