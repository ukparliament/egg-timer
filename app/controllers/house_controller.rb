class HouseController < ApplicationController
  
  def index
    @houses = House.all
    @title = "Houses"
  end
  
  def show
    house = params[:house]
    @house = House.find( house )
    @title = @house.name
  end
  
  def upcoming_all
    upcoming_sitting_days = SittingDay.find_by_sql(
      "
        SELECT house_id as house_id, start_date AS start_date, end_date AS end_date, 'Sitting day' AS day_type
        FROM sitting_days
        WHERE start_date >= '#{Date.today}'
        ORDER BY start_date ASC
      "
    )
    
    upcoming_virtual_sitting_days = VirtualSittingDay.find_by_sql(
      "
        SELECT house_id as house_id, start_date AS start_date, end_date AS end_date, 'Virtual sitting day' AS day_type
        FROM virtual_sitting_days
        WHERE start_date >= '#{Date.today}'
        ORDER BY start_date ASC
      "
    )
    
    upcoming_adjournment_days = AdjournmentDay.find_by_sql(
      "
        SELECT house_id as house_id, date AS start_date, date AS end_date, 'Adjournment day' AS day_type
        FROM adjournment_days
        WHERE date >= '#{Date.today}'
        ORDER BY date ASC
      "
    )
    
    @upcoming = upcoming_sitting_days + upcoming_virtual_sitting_days + upcoming_adjournment_days
    @upcoming.sort! { |a, b|  a.start_date <=> b.start_date }

    @title = 'Upcoming'
    @calendar_links = []
    calendar_link = ["Upcoming dates in both Houses", house_upcoming_all_url( :format => 'ics' )]
    @calendar_links << calendar_link
  end
end
