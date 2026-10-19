# frozen_string_literal: true

class Houses < MCP::Tool
  title "List houses"
  description "A tool to list Houses in the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      houses = House.all.order( 'name' )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: houses.to_json
          }
        ]
      )
    end
  end
end