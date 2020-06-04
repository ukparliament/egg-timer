namespace :util do
  desc "bundle exec rails server"
  task bers: :environment do
    print `bundle exec rails server`
  end

end
