bin/rails db:environment:set RAILS_ENV=development
bundle exec rake db:drop
bundle exec rake db:create
./heroku_file_to_db.sh

