# frozen_string_literal: true

class HouseVirtualSittingDaysUpcoming < MCP::Tool
  title "List upcoming virtual sitting days in a House"
  description "A tool to list upcoming virtual sitting days in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
    },
    required: ["house_name"],
  )

  class << self
    def call( house_name: )
    virtual_sitting_days = VirtualSittingDay.find_by_sql(
      [
        "
          SELECT vsd.*
          FROM virtual_sitting_days vsd, houses h
          WHERE vsd.house_id = h.id
          AND h.name = ?
          AND vsd.start_date > ?
        ", house_name, Date.today
      ]
    )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: virtual_sitting_days.to_json
          }
        ]
      )
    end
  end
end