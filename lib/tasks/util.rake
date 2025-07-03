namespace :util do
  desc "bundle exec rails server"
  task bers: :environment do
    print `bundle exec rails server`
  end
  
  desc "Tidy up detailed logs"
  task tidy_up_detailed_logs: :environment do
	  DetailedSyncLog.where('created_at < ?', 1.week.ago).delete_all
  end
end
