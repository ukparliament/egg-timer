class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  $SITE_TITLE = 'Parliamentary time'

  before_action do
    create_crumb_container
    setup_calendar_link_array
  end
  
  def create_crumb_container
    @crumb = []
  end
  
  def setup_calendar_link_array
    @calendar_links = []
  end
end
