class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  $SITE_TITLE = 'Parliamentary time'

  before_action do
    create_crumb_container
    setup_calendar_link_array
    check_whether_data_is_stale
    show_start_date_calculator?
  end
  
  def create_crumb_container
    @crumb = []
  end
  
  def show_start_date_calculator?
    @show_start_date_calculator = true
    @show_start_date_calculator = false if ENV['SHOW_START_DATE_CALCULATOR'] and ENV['SHOW_START_DATE_CALCULATOR'] == 'FALSE'
  end
  
  def setup_calendar_link_array
    @calendar_links = []
  end

  def check_whether_data_is_stale
    @stale_data = DetailedSyncLog.where(successful: false).any?
  end
end
