# frozen_string_literal: true

class ParliamentProrogations < MCP::Tool
  title "List prorogations in a Parliament"
  description "A tool to list prorogation periods in a Parliament period for the UK Parliament"
  input_schema(
    properties: {
      parliament_number: { type: "integer" },
    },
    required: ["parliament_number"],
  )

  class << self
    def call( parliament_number: )
      prorogation_periods = ProrogationPeriod.find_by_sql(
        [
          "
            SELECT pr.*
            FROM prorogation_periods pr, parliament_periods p
            WHERE pr.parliament_period_id = p.id
            AND p.number = ?
          ", parliament_number
        ]
      )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: prorogation_periods.to_json
          }
        ]
      )
    end
  end
end