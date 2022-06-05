class HouseDaysController < ApplicationController
  
  def upcoming
    house = params[:house]
    @house = House.find( house )
  end
  
  def sitting_day_list
    house = params[:house]
    @house = House.find( house )
  end
  
  def sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
  end
  
  def sitting_day_next
    house = params[:house]
    @house = House.find( house )
  end
  
  def virtual_sitting_day_list
    house = params[:house]
    @house = House.find( house )
  end
  
  def virtual_sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
  end
  
  def virtual_sitting_day_next
    house = params[:house]
    @house = House.find( house )
  end
  
  def adjournment_day_list
    house = params[:house]
    @house = House.find( house )
  end
  
  def adjournment_day_upcoming
    house = params[:house]
    @house = House.find( house )
  end
  
  def adjournment_day_next
    house = params[:house]
    @house = House.find( house )
  end
end
