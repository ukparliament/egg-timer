class MetaController < ApplicationController
  
  def index
  	@title = "About this application"
  end
  
  def using
  	@title = "Using the application"
  end
  
  def calendar_sync
  	@title = "How the calendar uses the information you create"
  end
  
  def prorogation_and_dissolution
  	@title = "What to do at prorogation and dissolution"
  end
  
  def schema
  	@title = "Database schema"
  end
  
  def comment
  	@title = "Comments"
  end
  
  def subscribe
  	@title = "Subscribe to calendars"
  end
  
  def app
  	@title = "MacOS application"
  end
  
  def recess_checker
  	@title = "Recess date checker"
    
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
          "
            SELECT ad.*
            FROM adjournment_days ad
            WHERE ad.house_id = #{upcoming_recess_date.house_id}
            AND ad.date = '#{recess_day}'
          "
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
  end
end
