# frozen_string_literal: true

class HouseDayType < MCP::Tool
  title "Return the type of a day in a House"
  description "A tool to return the type of a day in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
      date: { type: "string" },
    },
    required: ["house_name", "date"],
  )

  class << self
    def call( house_name:, date: )
    
      # We convert the date string to a date.
      date = date.to_date
      
      # If the request is for the House of Commons ...
      if house_name == 'House of Commons'
      
        # ... we set the day type for the House of Commons.
        day_type = date.commons_day_type
        
      # Otherwise, if the request is for the House of Lords ...
      elsif  house_name == 'House of Lords'
      
        # ... we set the day type for the House of Lords.
        day_type = date.lords_day_type
      end
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: day_type.to_json
          }
        ]
      )
    end
  end
end