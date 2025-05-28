class CalendarController < ApplicationController
  
  def index
    
    # Find the earliest sitting or adjournment date in the database.
    earliest_dates = []
    
    earliest_sitting_date = SittingDay.find_by_sql(
      "
        SELECT start_date 
        FROM sitting_days
        ORDER BY start_date
        LIMIT 1
      "
    )
    earliest_dates << earliest_sitting_date.first.start_date
    
    earliest_virtual_sitting_date = VirtualSittingDay.find_by_sql(
      "
        SELECT start_date 
        FROM virtual_sitting_days
        ORDER BY start_date
        LIMIT 1
      "
    )
    earliest_dates << earliest_virtual_sitting_date.first.start_date
    
    earliest_adjournment_date = AdjournmentDay.find_by_sql(
      "
        SELECT date 
        FROM adjournment_days
        ORDER BY date
        LIMIT 1
      "
    )
    earliest_dates << earliest_adjournment_date.first.date
    earliest_year = earliest_dates.min.year
    
    # Find the latest sitting or adjournment date in the database.
    latest_dates = []
    
    latest_sitting_date = SittingDay.find_by_sql(
      "
        SELECT start_date 
        FROM sitting_days
        ORDER BY start_date desc
        LIMIT 1
      "
    )
    latest_dates << latest_sitting_date.first.start_date
    
    latest_virtual_sitting_date = VirtualSittingDay.find_by_sql(
      "
        SELECT start_date 
        FROM virtual_sitting_days
        ORDER BY start_date desc
        LIMIT 1
      "
    )
    latest_dates << latest_virtual_sitting_date.first.start_date
    
    latest_adjournment_date = AdjournmentDay.find_by_sql(
      "
        SELECT date 
        FROM adjournment_days
        ORDER BY date desc
        LIMIT 1
      "
    )
    latest_dates << latest_adjournment_date.first.date
    latest_year = latest_dates.max.year
    
    @years = [*earliest_year..latest_year].reverse

    # Set meta information for the page.
    @page_title = "Calendar"
    @description = "Calendar."
    @crumb << { label: 'Calendar', url: nil }
    @section = 'calendar'
  end
  
  def today
    today = Date.today
    redirect_to calendar_day_url( :year => today.strftime( '%Y' ), :month => today.strftime( '%m' ), :day => today.strftime( '%d' ) )
  end
  
  def year
    year = params[:year]
    @year = year.to_i
    start_date = Date.new( @year, 1, 1 )
    end_date = Date.new( @year, 12, 31 )
    date_range = ( ( start_date )..( end_date ) ).to_a
    @month_range = []
    date_range.each do |date|
      @month_range << [date.strftime( '%B' ), date.strftime( '%m' ), date.strftime( '%Y' )]
    end
    @month_range.uniq!

    # Set meta information for the page.
    @page_title = @year
    @description = "#{@year}."
    @crumb << { label: 'Calendar', url: calendar_list_url }
    @crumb << { label: @year, url: nil }
    @section = 'calendar'
  end

  def month
    year = params[:year]
    month = params[:month]
    @year = year.to_i
    @month = month.to_i
    start_date = Date.new( @year, @month, 1)
    end_date = Date.new( @year, @month, -1)
    @date_range = ( ( start_date )..( end_date ) ).to_a
    @previous_date = start_date - 1.month
    @next_date = start_date + 1.month

    # Set meta information for the page.
    @page_title = "#{Date::MONTHNAMES[@month]} #{@year}"
    @description = "Calendar days in #{Date::MONTHNAMES[@month]} #{@year}."
    @crumb << { label: 'Calendar', url: calendar_list_url }
    @crumb << { label: @year, url: calendar_year_url }
    @crumb << { label: Date::MONTHNAMES[@month], url: nil }
    @section = 'calendar'
  end

  def day
    year = params[:year]
    month = params[:month]
    day = params[:day]
    @year = year.to_i
    @month = month.to_i
    @day = day.to_i
    @date = Date.new( @year, @month, @day )
    @previous_date = @date - 1.day
    @next_date = @date + 1.day
    @preceding_session = @date.preceding_session
    @following_session = @date.following_session
    @is_final_day_of_session = @date.is_final_day_of_session?

    # Set meta information for the page.
    @page_title = "#{@date.strftime( '%-e').to_i.ordinalize} #{@date.strftime( '%B %Y' ) }"
    @description = "#{@date.strftime( '%-e').to_i.ordinalize} #{@date.strftime( '%B %Y' ) }."
    @crumb << { label: 'Calendar', url: calendar_list_url }
    @crumb << { label: @year, url: calendar_year_url }
    @crumb << { label: Date::MONTHNAMES[@month], url: calendar_month_url }
    @crumb << { label: @date.strftime( '%-e').to_i.ordinalize, url: nil }
    @section = 'calendar'
  end
end
