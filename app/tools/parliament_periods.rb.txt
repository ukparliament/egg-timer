# frozen_string_literal: true

class ParliamentPeriods < MCP::Tool
  title "List parliament periods"
  description "A tool to list parliament periods for the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      parliament_periods = ParliamentPeriod.all.order( 'start_date' )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: parliament_periods.to_json
          }
        ]
      )
    end
  end
end