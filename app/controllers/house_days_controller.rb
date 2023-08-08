class HouseDaysController < ApplicationController
  
  def upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming'
    @calendar_links = []
    calendar_link = ["Upcoming dates in the #{@house.name}", house_days_upcoming_url( :format => 'ics' )]
    @calendar_links << calendar_link
  end
  
  def sitting_day_list
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - sitting days'
  end
  
  def sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming sitting days'
  end
  
  def sitting_day_next
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - next sitting day'
  end
  
  def sitting_day_preceding
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - preceding sitting days'
  end
  
  def sitting_day_latest
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - latest sitting day'
  end
  
  def virtual_sitting_day_list
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - virtual sitting days'
  end
  
  def virtual_sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming virtual sitting days'
  end
  
  def virtual_sitting_day_next
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - next virtual sitting day'
  end
  
  def virtual_sitting_day_preceding
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - preceding virtual sitting days'
  end
  
  def virtual_sitting_day_latest
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - latest virtual sitting day'
  end
  
  def adjournment_day_list
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - adjournment days'
  end
  
  def adjournment_day_upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming adjournment days'
  end
  
  def adjournment_day_next
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - next adjournment day'
  end
  
  def adjournment_day_preceding
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - preceding adjournment days'
  end
  
  def adjournment_day_latest
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - latest adjournment day'
  end
  
  def recess_dates
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - recess dates'
  end
  
  def recess_dates_upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming recess dates'
    @calendar_links = []
    calendar_link = ["Upcoming recess dates in the #{@house.name}", house_days_recess_dates_upcoming_url( :format => 'ics' )]
    @calendar_links << calendar_link
  end
end
