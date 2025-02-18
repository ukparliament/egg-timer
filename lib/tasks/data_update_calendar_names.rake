namespace :data do
	desc "One off update test calendar_names"
	task one_off_update_test_calendar_data: :environment do

		commons = House.find_by(name: "House of Commons")
		lords = House.find_by(name: "House of Lords")

		SyncToken.find_by(google_calendar_id: "08c47a45c4ad926a2ed5690d5de6664ec4ed5f25ee77e3cbab1bd2b3b54cd804@group.calendar.google.com").update(google_calendar_name: "Commons sitting days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "9dc2afe4c49604de9a88e836449a49a90356e2796f626d5aa896fc6f64c6fab8@group.calendar.google.com").update(google_calendar_name: "Commons adjournment days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "c168720cd26912a9f1f872e5c87d41809b5ffd0ec08194c23bf9ceca17b8f043@group.calendar.google.com").update(google_calendar_name: "Commons recess days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "321431db1e84f9c1743f5b1c3291a1544fbda486f8ccc2d1a021b448598de92e@group.calendar.google.com").update(google_calendar_name: "Lords sitting days calendar", house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "902c32b23639d887c56c9a2cef82c9d0dc352d3e5967bc4806062dbf917920d5@group.calendar.google.com").update(google_calendar_name: "Lords virtual sittings days calendar",  house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "d3333dda8d0fc131f470bc145c5d6b9fedc9a449827fc3dcf485290ce123819b@group.calendar.google.com").update(google_calendar_name: "Lords adjournment days calendar", house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "843571d922480c5de55c8a354e31eb59061a58b11ff9fca2b8bd154a62bf7b92@group.calendar.google.com").update(google_calendar_name: "Lords recess days calendar",  house_id: lords.id)

		raise StandardError if SyncToken.where(google_calendar_name: nil).any?
	end

	desc "One off update production calendar_names"
	task one_off_update_production_calendar_data: :environment do

		commons = House.find_by(name: "House of Commons")
		lords = House.find_by(name: "House of Lords")

		SyncToken.find_by(google_calendar_id: "20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com").update(google_calendar_name: "Commons sitting days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com").update(google_calendar_name: "Commons adjournment days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "eefeb6980f4ee93bd3d486b318141524452c82b8388066ef868e3443a549e3c3@group.calendar.google.com").update(google_calendar_name: "Commons recess days calendar", house_id: commons.id)
		SyncToken.find_by(google_calendar_id: "o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com").update(google_calendar_name: "Lords sitting days calendar",  house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com").update(google_calendar_name: "Lords virtual sittings days calendar",  house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com").update(google_calendar_name: "Lords adjournment days calendar",  house_id: lords.id)
		SyncToken.find_by(google_calendar_id: "45591a2f31eb089019ba1b200e5ec635f8d25a9620f120e96e881b3165e714d4@group.calendar.google.com").update(google_calendar_name: "Lords recess days calendar",  house_id: lords.id)

		raise StandardError if SyncToken.where(google_calendar_name: nil).any?
	end
end
