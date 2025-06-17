class SessionController < ApplicationController
  
  def index
    @sessions = Session.all.order( 'start_date desc' )
    @title = "Sessions"

    # Set a meta information for the page.
    @page_title = "Sessions"
    @description = "Sessions."
    @csv_url = session_list_url( :format => 'csv' )
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Sessions', url: nil }
    @section = 'time-periods'
  end
  
  def show
    session = params[:session]
    @session = Session.find( session )
    @houses = House.all
    @title = @session.label_with_parliament

    # Set a meta information for the page.
    @page_title = @session.label_with_parliament
    @description = "#{@session.label_with_parliament}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Parliament periods', url: parliament_list_url }
    @crumb << { label: @session.parliament_label, url: parliament_show_url( :parliament => @session.parliament_period_id )}
    @crumb << { label: @session.label_in_parliament, url: nil }
    @section = 'time-periods'
  end
end
