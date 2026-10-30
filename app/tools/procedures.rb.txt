# frozen_string_literal: true

class Procedures < MCP::Tool
  title "List procedures"
  description "A tool to list procedures in the UK Parliament"
  input_schema(
    properties: {
    },
  )

  class << self
    def call
      procedures = Procedure
        .all
        .where( 'active is true' )
        .order( 'display_order asc' )
      
      MCP::Tool::Response.new(
        [
          {
            type: "text",
            text: procedures.to_json
          }
        ]
      )
    end
  end
end