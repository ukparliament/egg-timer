class HouseDaysController < ApplicationController
  
  def upcoming
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - upcoming days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Upcoming days</span>".html_safe
    @description = "Upcoming days in the #{@house.name}."
    @calendar_links << ["Upcoming days in the #{@house.name}", house_days_upcoming_url( :format => 'ics' )]
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Upcoming days', url: nil }
    @section = 'time-periods'
  end
  
  def sitting_day_next
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - next sitting day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Next sitting day</span>".html_safe
    @description = "Next sitting day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Next sitting day', url: nil }
    @section = 'time-periods'
  end
  
  def sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - upcoming sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Upcoming sitting days</span>".html_safe
    @description = "Upcoming sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Upcoming sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def sitting_day_list
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Sitting days</span>".html_safe
    @description = "Sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def sitting_day_preceding
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - preceding sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Preceding sitting days</span>".html_safe
    @description = "Preceding sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Preceding sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def sitting_day_latest
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - latest sitting day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Latest sitting day</span>".html_safe
    @description = "Latest sitting day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Latest sitting day', url: nil }
    @section = 'time-periods'
  end
  
  def virtual_sitting_day_next
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - next virtual sitting day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Next virtual sitting day</span>".html_safe
    @description = "Next virtual sitting day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Next virtual sitting day', url: nil }
    @section = 'time-periods'
  end
  
  def virtual_sitting_day_upcoming
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - upcoming virtual sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Upcoming virtual sitting days</span>".html_safe
    @description = "Upcoming virtual sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Upcoming virtual sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def virtual_sitting_day_list
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - virtual sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Virtual sitting days</span>".html_safe
    @description = "Virtual sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Virtual sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def virtual_sitting_day_preceding
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - preceding virtual sitting days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Preceding virtual sitting days</span>".html_safe
    @description = "Preceding virtual sitting days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Preceding virtual sitting days', url: nil }
    @section = 'time-periods'
  end
  
  def virtual_sitting_day_latest
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - latest virtual sitting day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Latest virtual sitting day</span>".html_safe
    @description = "Latest virtual sitting day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Latest virtual sitting day', url: nil }
    @section = 'time-periods'
  end
  
  def adjournment_day_next
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - next adjournment day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Next adjournment day</span>".html_safe
    @description = "Next adjournment day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Next adjournment day', url: nil }
    @section = 'time-periods'
  end
  
  def adjournment_day_upcoming
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - upcoming adjournment days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Upcoming adjournment days</span>".html_safe
    @description = "Upcoming adjournment days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Upcoming adjournment days', url: nil }
    @section = 'time-periods'
  end
  
  def adjournment_day_list
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - adjournment days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Adjournment days</span>".html_safe
    @description = "Adjournment days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Adjournment days', url: nil }
    @section = 'time-periods'
  end
  
  def adjournment_day_preceding
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - preceding adjournment days"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Preceding adjournment days</span>".html_safe
    @description = "Preceding adjournment days in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Preceding adjournment days', url: nil }
    @section = 'time-periods'
  end
  
  def adjournment_day_latest
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - latest adjournment day"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Latest adjournment day</span>".html_safe
    @description = "Latest adjournment day in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Latest adjournment day', url: nil }
    @section = 'time-periods'
  end
  
  
  
  
  
  
  
  def recess_dates_upcoming
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - upcoming recess dates"
    @multiline_page_title = "#{@house.name} <span class='subhead'>Upcoming recess dates</span>".html_safe
    @description = "Upcoming recess dates in the #{@house.name}."
    @calendar_links << ["Upcoming recess dates in the #{@house.name}", house_days_recess_dates_upcoming_url( :format => 'ics' )]
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'Upcoming recess dates', url: nil }
    @section = 'time-periods'
  end
  
  def recess_dates
    house = params[:house]
    @house = House.find( house )
    
    # Set meta information for the page.
    @page_title = "#{@house.name} - all recess dates"
    @multiline_page_title = "#{@house.name} <span class='subhead'>All recess dates</span>".html_safe
    @description = "All recess dates in the #{@house.name}."
    @crumb << { label: 'Time periods', url: parliamentary_time_list_url }
    @crumb << { label: 'Houses', url: house_list_url }
    @crumb << { label: @house.name, url: house_show_url }
    @crumb << { label: 'All recess dates', url: nil }
    @section = 'time-periods'
  end
end
