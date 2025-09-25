class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include LibraryDesign::Crumbs
  include LibraryDesign::CalendarLinks
  
  $SITE_TITLE = 'Parliamentary Time'
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )

  before_action do
    setup_calendar_link_array
    check_whether_data_is_stale
  end
  
  def setup_calendar_link_array
    @calendar_links = []
  end

  def check_whether_data_is_stale
    @stale_data = DetailedSyncLog.where(successful: false).any?
  end
end
