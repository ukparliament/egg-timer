module CALCULATION_INTERVAL
  
  # # A method for calculating the number of sitting days in both Houses during an interval.
  # We pass the start and end dates of the interval.
  
  def calculate_sitting_days_in_interval( start_date, end_date )
    
    # We set the date to start counting from to the start date.
    date = @start_date
    
    # Whilst the date is not later than the end date ...
    while date <= @end_date
      
      # If the date is a Commons sitting day ...
      if date.is_commons_parliamentary_sitting_day?
        
        # ... we increment the Commons sitting day count.
        @commons_sitting_day_count += 1
      end
      
      # If the date is a Lords sitting day ...
      if date.is_lords_parliamentary_sitting_day?
        
        # ... we increment the Lords sitting day count.
        @lords_sitting_day_count += 1
      end
      
      # We continue to the **next day**.
      date = date.next_day
    end
  end
end