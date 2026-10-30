# frozen_string_literal: true

class ParliamentSessions < MCP::Tool
  title "List sessions in a Parliament"
  description "A tool to list sessions in a Parliament period for the UK Parliament"
  input_schema(
    properties: {
      parliament_number: { type: "integer" },
    },
    required: ["parliament_number"],
  )

  class << self
    def call( parliament_number: )
      sessions = Session.find_by_sql(
        [
          "
            SELECT s.*
            FROM sessions s, parliament_periods p
            WHERE s.parliament_period_id = p.id
            AND p.number = ?
          ", parliament_number
        ]
      )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: sessions.to_json
          }
        ]
      )
    end
  end
end