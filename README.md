# The Egg Timer — powered by House of Commons librarians

## What does the egg timer do?

The [Egg timer](https://parliament-egg-timer.herokuapp.com/) application has a number of features:

 *  Reference data - e.g. [Dissolution periods](https://parliament-egg-timer.herokuapp.com/egg-timer/dissolution-periods), [Parliamentary periods](https://parliament-egg-timer.herokuapp.com/egg-timer/parliament-periods), [Sessions](https://parliament-egg-timer.herokuapp.com/egg-timer/sessions), [Houses](https://parliament-egg-timer.herokuapp.com/egg-timer/houses)

 * A calendar view showing whether either house is sitting, or adjourned, scrutiny non-sitting days etc.. along with whether each house is praying or not.

 * Calculuate sitting days during an interval

 * Documenting the different available periods

 * A guide to events, what to do a prorogation and dissolution etc

 * Checks around whether the synchronisation processes are working or not

## What are the data sources?

The egg timer synchronises data from a few different sources:

* The [parliamentary periods and sessions spreadsheet](https://docs.google.com/spreadsheets/d/1e3AnQebAO5ug-Pc_0qDq9KkyZiy0dRhJMvm0lRRJOXk/edit?gid=0#gid=0) - this has two tabs

  * Parliament periods
  * Sessions

* The following public google calendars:

  * [Common's adjournment days calendar](https://calendar.google.com/calendar/embed?src=ikdqq0rcg07bbs64g7aeqqlkt4%40group.calendar.google.com&ctz=Europe%2FLondon)

  * [Common's sitting days calendar](https://calendar.google.com/calendar/embed?src=20n14bks46tvd2k5rse3jmsfb4%40group.calendar.google.com&ctz=Europe%2FLondon)

  * [Lord's adjournment days calendar](https://calendar.google.com/calendar/embed?src=ibbc1cen1mdm6rsf6kkno17i0c%40group.calendar.google.com&ctz=Europe%2FLondon)

  * [Lord's sitting days calendar](https://calendar.google.com/calendar/embed?src=o26tfi8b5o78cborja7utgpcb8%40group.calendar.google.com&ctz=Europe%2FLondon)

  * [Lord's virtual days calendar](https://calendar.google.com/calendar/embed?src=p1lfs3elv1fk0lqdigs3jngop8%40group.calendar.google.com&ctz=Europe%2FLondon) - the Lords continue to have virtual days, the Commons do not.

  * [Common's recess calendar](https://calendar.google.com/calendar/embed?src=eefeb6980f4ee93bd3d486b318141524452c82b[…]443a549e3c3%40group.calendar.google.com&ctz=Europe%2FLondon)

  * [Lord's recess calendar](https://calendar.google.com/calendar/embed?src=45591a2f31eb089019ba1b200e5ec635f8d25a9[…]b3165e714d4%40group.calendar.google.com&ctz=Europe%2FLondon)

These calendars are currently owned by a couple of users using their own google account.

### Synchronisation
#### Database

A postgres database is used to store the calendar events for the website.

#### Calendar authorisation

The application simply reads the various environment variables set up with the google credentials in Heroku. For running locally, a `.env` file is required with the credentials.

#### Calendars

The calendars are synchronised using the simple ruby Google API client (RESTful). The 'modern' client does not provide a calendar endpoint. The simple endpoints are still supported by Google.

Authorisation is by using a standard google service account - this is the recommended way for using this ruby API.

The latest synchronisation date is stored, so that only entries *after* that date are added to the database.

#### Sessions and Parliamentary periods

These are imported from the CSV files in `db/data` using the [setup.rake](lib/tasks/setup.rake) task

### Sync failures

The calendar uses the sync token functionality provided by the API so that the client can request any changes since the last sync, rather than having to do a full refresh.

The app stores the sync token once one of the calendars has synchronised.

Once all of the calendars have synchronised, a CalendarSync record is created which then provides a timestamp of when the last succesful run was complete.

Sometimes a synchronisation will fail with this message from the API:

```
Google::Apis::ClientError: fullSyncRequired: Sync token is no longer valid, a full sync is required. (Google::Apis::ClientError)
```

When this occurs, a full reset of the database is then required.

There is a guide to resetting the database in [Prorogration and Dissolution](app/views/meta/prorogation_and_dissolution.html.erb) or [online](https://api.parliament.uk/egg-timer/meta/prorogation-and-dissolution#resetting-the-database)

### Proposed changes part 1

If, when the synchronisation fails, a message is sent to the app maintainers, with details of the failed calendar, then further investigation can then be undertaken to work out what went wrong, plus it is possible that that single calendar can the be fixed by:

 1) Deleting the relevant database records
 2) Deleting the relevant sync token
 3) Manually running a sync which should
     a) Do a full sync for that calendar
     b) Create a new sync token

### Proposed changes part 2

Once we have a bit more of an insight into the sync failures, we might have a better plan, but else, the second part of the update would be to automate the steps above.

## Setting up for dev

Ideally we will use the test environment credentials for development, but we can pull the database from Heroku (see below)

Then we need a `.env` file in the application route to set up our environment variables - these will be picked up automatically when the rails app is started, as we use the `dotenv` gem to locally read the `.env` file.

If running against test, then copy the credentials set on the test environment for the Google auth fields

### Example .env file

```
GOOGLE_ACCOUNT_TYPE=service_account
GOOGLE_CLIENT_EMAIL=
GOOGLE_CLIENT_ID=
GOOGLE_PRIVATE_KEY=

# Production
# COMMONS_SITTING_DAYS_CALENDAR='20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com'
# LORDS_SITTING_DAYS_CALENDAR='o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com'
# LORDS_VIRTUAL_SITTING_DAYS_CALENDAR='p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com'
# COMMONS_ADJOURNMENT_DAYS_CALENDAR='ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com'
# LORDS_ADJOURNMENT_DAYS_CALENDAR='ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com'
# COMMONS_RECESS_DAYS_CALENDAR='eefeb6980f4ee93bd3d486b318141524452c82b8388066ef868e3443a549e3c3@group.calendar.google.com'
# LORDS_RECESS_DAYS_CALENDAR='45591a2f31eb089019ba1b200e5ec635f8d25a9620f120e96e881b3165e714d4@group.calendar.google.com'

# Test
COMMONS_SITTING_DAYS_CALENDAR="08c47a45c4ad926a2ed5690d5de6664ec4ed5f25ee77e3cbab1bd2b3b54cd804@group.calendar.google.com"
LORDS_SITTING_DAYS_CALENDAR="321431db1e84f9c1743f5b1c3291a1544fbda486f8ccc2d1a021b448598de92e@group.calendar.google.com"
LORDS_VIRTUAL_SITTING_DAYS_CALENDAR="902c32b23639d887c56c9a2cef82c9d0dc352d3e5967bc4806062dbf917920d5@group.calendar.google.com"
COMMONS_ADJOURNMENT_DAYS_CALENDAR="9dc2afe4c49604de9a88e836449a49a90356e2796f626d5aa896fc6f64c6fab8@group.calendar.google.com"
LORDS_ADJOURNMENT_DAYS_CALENDAR="d3333dda8d0fc131f470bc145c5d6b9fedc9a449827fc3dcf485290ce123819b@group.calendar.google.com"
COMMONS_RECESS_DAYS_CALENDAR="c168720cd26912a9f1f872e5c87d41809b5ffd0ec08194c23bf9ceca17b8f043@group.calendar.google.com"
LORDS_RECESS_DAYS_CALENDAR="843571d922480c5de55c8a354e31eb59061a58b11ff9fca2b8bd154a62bf7b92@group.calendar.google.com"
```

## Pulling db from Heroku

For production

`heroku pg:pull DATABASE_URL parliament_calendar --app parliament-egg-timer`

For test

`heroku pg:pull DATABASE_URL parliament_calendar --app egg-timer-test`

If you want to drop a local db first:

`dropdb parliament_calendar; heroku pg:pull DATABASE_URL parliament_calendar --app egg-timer-test`

Using commentariat (does this still work?):

```ruby commentariat.rb -s lib/ -o demo```

... where "demo" is the output directory.