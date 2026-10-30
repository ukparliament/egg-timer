# frozen_string_literal: true

class HouseRecessesUpcoming < MCP::Tool
  title "List upcoming recesses in a House"
  description "A tool to list upcoming recesses in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
    },
    required: ["house_name"],
  )

  class << self
    def call( house_name: )
    recesses = RecessDate.find_by_sql(
      [
        "
          SELECT r.*
          FROM recess_dates r, houses h
          WHERE r.house_id = h.id
          AND h.name = ?
          AND r.start_date > ?
        ", house_name, Date.today
      ]
    )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: recesses.to_json
          }
        ]
      )
    end
  end
end