# frozen_string_literal: true

class ProrogationPeriods < MCP::Tool
  title "List prorogation periods"
  description "A tool to list prorogation periods of the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      prorogation_periods = ProrogationPeriod.all.order( 'start_date' )
      
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