# module DevTestDBDrop
#   def drop_database(name) # :nodoc:
#     ap "HI"
#     execute "DROP DATABASE IF EXISTS #{quote_table_name(name)} WITH (FORCE)"
#   end
# end

# require 'active_record/connection_adapters/postgresql_adapter/schema_statements'

# #ActiveRecord::ConnectionAdapters::PostgreSQL::SchemaStatements.include(DevTestDBDrop) if Rails.env.development? || Rails.env.test?
# ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::SchemaStatements.include(DevTestDBDrop) if Rails.env.development? || Rails.env.test?