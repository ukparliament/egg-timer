class CalendarController < ApplicationController
  
  def index
    @title = "Calendar"
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
  end
end
