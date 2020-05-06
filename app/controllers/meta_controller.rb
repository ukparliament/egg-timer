class MetaController < ApplicationController
  
  def index
  	@title = "About this application"
  end
  
  def calendar_sync
  	@title = "How the calendar uses the information you create"
  end
end
