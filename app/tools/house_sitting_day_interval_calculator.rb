# frozen_string_literal: true

class HouseSittingDayIntervalCalculator < MCP::Tool
  title "Return the number of sittings days in an interval in a House"
  description "A tool to return the number of sitting days in an interval in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
      start_date: { type: "string" },
      end_date: { type: "string" },
    },
    required: ["house_name", "start_date", "end_date"],
  )

  class << self
    include Calculations::Interval
    
    def call( house_name:, start_date:, end_date: )
    
      # We convert the start and end date strings to dates.
      start_date = start_date.to_date
      end_date = end_date.to_date
      
      # We set the sitting day counts for each House.
      @commons_sitting_day_count = 0
      @lords_sitting_day_count = 0
      
      # We calculate the sitting days in the interval in both Houses.
      calculate_sitting_days_in_interval( start_date, end_date )
      
      # If the request is for the House of Commons ...
      if house_name == 'House of Commons'
      
        # ... we set the day count to the House of Commons day count.
        day_count = @commons_sitting_day_count
        
      # Otherwise, if the request is for the House of Lords ...
      elsif house_name == 'House of Lords'
      
        # ... we set the day count to the House of Lords day count.
        day_count = @lords_sitting_day_count
      end
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: day_count.to_json
          }
        ]
      )
    end
  end
end