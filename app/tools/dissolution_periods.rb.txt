# frozen_string_literal: true

class DissolutionPeriods < MCP::Tool
  title "List dissolution periods"
  description "A tool to list dissolution periods of the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      dissolution_periods = DissolutionPeriod.all.order( 'start_date' )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: dissolution_periods.to_json
          }
        ]
      )
    end
  end
end