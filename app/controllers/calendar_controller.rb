class CalendarController < ApplicationController
  
  def index
    @title = "Calendar"
    
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
  end
  
  def today
    today = Date.today
    puts "*****"
    puts today
    redirect_to calendar_day_url( :year => today.strftime('%Y'), :month => today.strftime('%-m'), :day => today.strftime('%e').strip )
  end
  
  def year
    year = params[:year]
    @title = year
    start_date = Date.new( year.to_i, 1, 1)
    end_date = Date.new( year.to_i, 12, 31)
    date_range = ( ( start_date )..( end_date ) ).to_a
    @month_range = []
    date_range.each do |date|
      @month_range << [date.strftime("%B"), date.month, date.year]
    end
    @month_range.uniq!
  end
  
  def year
    year = params[:year]
    @title = year
    start_date = Date.new( year.to_i, 1, 1)
    end_date = Date.new( year.to_i, 12, 31)
    date_range = ( ( start_date )..( end_date ) ).to_a
    @month_range = []
    date_range.each do |date|
      @month_range << [date.strftime("%B"), date.month, date.year]
    end
    @month_range.uniq!
  end

  def month
    year = params[:year]
    month = params[:month]
    @title = "#{Date::MONTHNAMES[month.to_i]} #{year}"
    start_date = Date.new( year.to_i, month.to_i, 1)
    end_date = Date.new( year.to_i, month.to_i, -1)
    @date_range = ( ( start_date )..( end_date ) ).to_a
    @previous_date = start_date - 1.month
    @next_date = start_date + 1.month
  end

  def day
    year = params[:year]
    month = params[:month]
    day = params[:day]
    @title = "#{day.to_i.ordinalize} #{Date::MONTHNAMES[month.to_i]} #{year}"
    @date = Date.new( year.to_i, month.to_i, day.to_i)
    @previous_date = @date - 1.day
    @next_date = @date + 1.day
  end
end
