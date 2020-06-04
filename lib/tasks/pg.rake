namespace :pg do
  desc "psql drop database parliament_calendar"
  task drop: :environment do
  	print `psql drop database parliament_calendar`
  end

  desc "heroku pg:pull DATABASE_URL parliament_calendar"
  task pull: :environment do
    print `heroku pg:pull DATABASE_URL parliament_calendar`
  end

end
