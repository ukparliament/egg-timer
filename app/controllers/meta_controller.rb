class MetaController < ApplicationController
  
  def index
  	@title = "About this application"
  end
  
  def calendar_sync
  	@title = "How the calendar uses the information you create"
  end
  
  def prorogation_dissolution
  	@title = "What to do at prorogation and dissolution"
  end
  
  def schema
  	@title = "Database schema"
  end
  
  def schema
  	@title = "Code"
  end
end
