class CalendarRedirectController < ApplicationController

  def month
    month = params[:month]
    month = '0' + month if month.length == 1
    redirect_to( calendar_month_url( :month => month ), :status => 301 )
  end

  def day
    month = params[:month]
    month = '0' + month if month.length == 1
    day = params[:day]
    day = '0' + day if day.length == 1
    redirect_to( calendar_day_url( :month => month, :day => day ), :status => 301 )
  end
end
