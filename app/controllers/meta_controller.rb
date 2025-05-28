class MetaController < ApplicationController

  # Main about page
  def index

    # Set a meta information for the page.
    @page_title = "About this application"
    @description = "About this application."
    @crumb << { label: 'About', url: nil }
  end
  
  def app
  	@title = "MacOS application"

    # Set a meta information for the page.
    @page_title = "MacOS application"
    @description = "MacOS application."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'MacOS application', url: nil }
  end
  
  def comment

    # Set a meta information for the page.
    @page_title = "Calculation code comments"
    @description = "Calculation code comments."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Calculation code comments', url: nil }
  end
  
  def schema

    # Set a meta information for the page.
    @page_title = "Database schema"
    @description = "Database schema."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Database schema', url: nil }
  end
  
  # Librarian tools
  def librarian_tools

    # Set a meta information for the page.
    @page_title = "Librarian tools"
    @description = "Librarian tools."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: nil }
    render :template => 'meta/librarian_tools/index'
  end
  
  def calendar_sync

    # Set a meta information for the page.
    @page_title = "How to populate the calendars"
    @description = "How to populate the calendars."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'How to populate the calendars', url: nil }
    render :template => 'meta/librarian_tools/calendar_sync'
  end
  
  def prorogation_and_dissolution

    # Set a meta information for the page.
    @page_title = "What to do at prorogation and dissolution"
    @description = "What to do at prorogation and dissolution."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'What to do at prorogation and dissolution', url: nil }
    render :template => 'meta/librarian_tools/prorogation_and_dissolution'
  end
  
  def recess_checker
    
    # We create an array to hold the error log.
    @error_log = []
    
    # We find all upcoming recess dates.
    upcoming_recess_dates = RecessDate.find_by_sql(
      "
        SELECT rd.*
        FROM recess_dates rd
        WHERE rd.end_date >= '#{Date.today}'
      "
    )
    
    # For each upcoming recess date ...
    upcoming_recess_dates.each do |upcoming_recess_date|
      
      # ... we find the house the recess is in.
      house = House.find( upcoming_recess_date.house_id )
      
      # For each day in the recess ...
      (upcoming_recess_date.start_date..upcoming_recess_date.end_date).each do |recess_day|
        
        # ... we attempt to find an adjournment day in the same House on that date.
        adjournment_day = AdjournmentDay.find_by_sql(
          [
          "
            SELECT ad.*
            FROM adjournment_days ad
            WHERE ad.house_id = ?
            AND ad.date = ?
          ", upcoming_recess_date.house_id, recess_day
          ]
        ).first
        
        # If there is not an adjournment day in this House on this day ...
        unless adjournment_day
          
          # ... we constuct an error message ...
          error_message = "#{recess_day.strftime( '%e %B %Y') } is part of the #{upcoming_recess_date.description} in the #{house.name}, but that date is not an adjournment day in that House."
          
          # ... and append it to the log.
          @error_log << error_message
        end
      end
    end

    # Set a meta information for the page.
    @page_title = "Recess date checker"
    @description = "Recess date checker."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Recess date checker', url: nil }
    render :template => 'meta/librarian_tools/recess_checker'
  end

  def detailed_sync_logs
    @detailed_sync_logs = DetailedSyncLog.order(updated_at: :desc).limit(98)

    # Set a meta information for the page.
    @page_title = "Detailed sync logs"
    @description = "Detailed sync logs."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Detailed sync logs', url: nil }
    render :template => 'meta/librarian_tools/detailed_sync_logs'
  end
  
  # Used elsewhere
  def using
    
    # Set a meta information for the page.
    @page_title = "Scrutiny end date calculator - how to use"
    @multiline_page_title = "Calculators <span class='subhead'>Scrutiny end date - how to use</span>".html_safe
    @description = "How to use the calculator to determine the estimated end date of scrutiny for instruments before Parliament."
    @crumb << { label: 'Calculators', url: calculator_list_url }
    @crumb << { label: 'Scrutiny end date', url: calculator_form_url }
    @crumb << { label: 'How to use', url: nil }
    @section = 'calculators'
    @subsection = 'scrutiny-calculator'
  end
  
  def subscribe
  	@title = "Subscribe to calendars"
    @calendar_links = []
    calendar_link = ["Upcoming recess dates in the House of Commons", house_days_recess_dates_upcoming_url( :house => 1, :format => 'ics' )]
    @calendar_links << calendar_link
    calendar_link = ["Upcoming recess dates in the House of Lords", house_days_recess_dates_upcoming_url( :house => 2, :format => 'ics' )]
    @calendar_links << calendar_link
    calendar_link = ["Upcoming dates in the House of Commons", house_days_upcoming_url( :house => 1, :format => 'ics' )]
    @calendar_links << calendar_link
    calendar_link = ["Upcoming dates in the House of Lords", house_days_upcoming_url( :house => 2, :format => 'ics' )]
    @calendar_links << calendar_link
    calendar_link = ["Upcoming dates in both Houses", house_upcoming_all_url( :format => 'ics' )]
    @calendar_links << calendar_link
    
    # Set a meta information for the page.
    @page_title = "Calendar subscriptions"
    @description = "Calendar subscriptions."
    @crumb << { label: 'Calendar subscriptions', url: nil }
    @section = 'calendar-subscriptions'
  end
  
  # No longer linked to
  def calendar_sync_checker
    @last_calendar_sync = CalendarSync.all.order( 'synced_at DESC' ).first
    
    # Set a meta information for the page.
    @page_title = "Calendar sync checker"
    @description = "Calendar sync checker."
    @crumb << { label: 'About', url: meta_list_url }
    @crumb << { label: 'Librarian tools', url: meta_librarian_tools_url }
    @crumb << { label: 'Calendar sync checker', url: nil }
  end
end
