require 'csv'

task :setup => [
  :import_parliaments,
  :import_sessions,
  :populate_dissolution_periods
]

task :import_parliaments => :environment do
  puts "importing parliaments"
  CSV.foreach( 'db/data/parliaments.csv' ) do |row|
    parliament_period = ParliamentPeriod.new
    parliament_period.number = row[0]
    parliament_period.start_on = row[2].to_date
    parliament_period.end_on = row[4].to_date if row[4]
    parliament_period.save
  end
end
task :import_sessions => :environment do
  puts "importing sessions"
  CSV.foreach( 'db/data/sessions.csv' ) do |row|
    session = Session.new
    session.number = row[1]
    session.start_on = row[2].to_date
    session.end_on = row[3].to_date if row[3]
    parliament_period = ParliamentPeriod.find_by number: row[0]
    session.parliament_period = parliament_period
    session.save
  end
end
task :populate_dissolution_periods => :environment do
  puts "populating dissolution periods from parliament periods"
  parliament_periods = ParliamentPeriod.all.where( 'end_on is not null' ).order( 'start_on' )
  parliament_periods.each do |parliament_period|
    dissolution_period = DissolutionPeriod.new
    dissolution_period.number = parliament_period.number
    dissolution_period.start_on = parliament_period.end_on + 1.day
    dissolution_period.end_on = parliament_period.following_parliament_period.start_on - 1.day
    dissolution_period.save
  end
end