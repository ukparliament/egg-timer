# frozen_string_literal: true

class HouseSittingDaysUpcoming < MCP::Tool
  title "List upcoming sitting days in a House"
  description "A tool to list upcoming sitting days in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
    },
    required: ["house_name"],
  )

  class << self
    def call( house_name: )
    sitting_days = SittingDay.find_by_sql(
      [
        "
          SELECT sd.*
          FROM sitting_days sd, houses h
          WHERE sd.house_id = h.id
          AND h.name = ?
          AND sd.start_date > ?
        ", house_name, Date.today
      ]
    )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: sitting_days.to_json
          }
        ]
      )
    end
  end
end