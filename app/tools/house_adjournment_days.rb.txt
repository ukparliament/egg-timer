# frozen_string_literal: true

class HouseAdjournmentDays < MCP::Tool
  title "List adjournment days in a House"
  description "A tool to list adjournment days in a House in the UK Parliament"
  input_schema(
    properties: {
      house_name: { type: "string" },
    },
    required: ["house_name"],
  )

  class << self
    def call( house_name: )
    adjournment_days = AdjournmentDay.find_by_sql(
      [
        "
          SELECT a.*
          FROM adjournment_days a, houses h
          WHERE a.house_id = h.id
          AND h.name = ?
        ", house_name
      ]
    )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: adjournment_days.to_json
          }
        ]
      )
    end
  end
end