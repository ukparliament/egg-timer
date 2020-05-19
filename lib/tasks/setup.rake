require 'csv'

task :setup => [
  :import_parliaments,
  :import_sessions,
  :populate_dissolution_periods,
  :populate_prorogation_periods,
  :import_houses,
  :populate_dissolution_days,
  :populate_prorogation_days
]

task :import_parliaments => :environment do
  puts "importing parliaments"
  CSV.foreach( 'db/data/parliaments.csv' ) do |row|
    parliament_period = ParliamentPeriod.new
    parliament_period.number = row[0]
    parliament_period.start_date = row[2].to_date
    parliament_period.end_date = row[4].to_date if row[4]
    parliament_period.save
  end
end
task :import_sessions => :environment do
  puts "importing sessions"
  CSV.foreach( 'db/data/sessions.csv' ) do |row|
    session = Session.new
    session.number = row[1]
    session.start_date = row[2].to_date
    session.end_date = row[3].to_date if row[3]
    parliament_period = ParliamentPeriod.find_by number: row[0]
    session.parliament_period = parliament_period
    session.save
  end
end
task :populate_dissolution_periods => :environment do
  puts "populating dissolution periods from parliament periods"
  parliament_periods = ParliamentPeriod.all.where( 'end_date is not null' ).order( 'start_date' )
  parliament_periods.each do |parliament_period|
    dissolution_period = DissolutionPeriod.new
    dissolution_period.number = parliament_period.number
    dissolution_period.start_date = parliament_period.end_date + 1.day
    dissolution_period.end_date = parliament_period.following_parliament_period.start_date - 1.day
    dissolution_period.save
  end
end
task :populate_prorogation_periods => :environment do
  puts "populating prorogation periods from sessions"
  sessions = Session.all.where( 'end_date is not null' ).order( 'start_date' )
  sessions.each do |session|
    # if there is a following session in the same parliament insert a prorogation between end of this session and start of this one
    if session.following_session_in_parliament
      prorogation_period = ProrogationPeriod.new
      prorogation_period.number = session.number
      prorogation_period.start_date = session.end_date + 1.day
      prorogation_period.end_date = session.following_session_in_parliament.start_date - 1.day
      prorogation_period.parliament_period = session.parliament_period
      prorogation_period.save
    # If there's no following session in the same parliament but this session ends before parliament ends insert a prorogation between end of this session and end of parliament
    elsif session.end_date < session.parliament_period.end_date
      prorogation_period = ProrogationPeriod.new
      prorogation_period.number = session.number
      prorogation_period.start_date = session.end_date + 1.day
      prorogation_period.end_date = session.parliament_period.end_date
      prorogation_period.parliament_period = session.parliament_period
      prorogation_period.save
    end
  end
end
task :import_houses => :environment do
  puts "importing houses"
  CSV.foreach( 'db/data/houses.csv' ) do |row|
    house = House.new
    house.name = row[0]
    house.save
  end
end
task :populate_dissolution_days => :environment do
  puts "populating dissolution days from dissolution periods"
  dissolution_periods = DissolutionPeriod.all
  dissolution_periods.each do |dissolution_period|
    ( dissolution_period.start_date..dissolution_period.end_date ).each do |date|
      dissolution_day = DissolutionDay.new
      dissolution_day.date = date
      dissolution_day.dissolution_period = dissolution_period
      dissolution_day.save
    end
  end
end
task :populate_prorogation_days => :environment do
  puts "populating prorogation days from prorogation periods"
  prorogation_periods = ProrogationPeriod.all
  prorogation_periods.each do |prorogation_period|
    ( prorogation_period.start_date..prorogation_period.end_date ).each do |date|
      prorogation_day = ProrogationDay.new
      puts prorogation_day.inspect
      prorogation_day.date = date
      prorogation_day.prorogation_period = prorogation_period
      prorogation_day.save
    end
  end
end