class HouseDaysController < ApplicationController
  
  def upcoming
    house = params[:house]
    @house = House.find( house )
    @title = @house.name + ' - upcoming'
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
end
