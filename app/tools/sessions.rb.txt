# frozen_string_literal: true

class Sessions < MCP::Tool
  title "List sessions"
  description "A tool to list sessions for the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      sessions = Session.all.order( 'start_date' )
      
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