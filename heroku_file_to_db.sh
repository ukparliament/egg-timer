pg_restore --verbose --clean --no-acl --no-owner -h localhost -d parliament_calendar latest.dump
bundle exec rake db:migrate

