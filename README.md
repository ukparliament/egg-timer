# egg-timer

Egg timer.

## What does the egg timer do

The [Egg timer](https://parliament-egg-timer.herokuapp.com/) application has a number of features:

 *  Reference data - e.g. [Dissolution periods](https://parliament-egg-timer.herokuapp.com/egg-timer/dissolution-periods), [Parliamentary perdiods](https://parliament-egg-timer.herokuapp.com/egg-timer/parliament-periods), [Sessions(https://parliament-egg-timer.herokuapp.com/egg-timer/sessions), [Houses](https://parliament-egg-timer.herokuapp.com/egg-timer/houses)

 * A calendar view showing whether either house is sitting, or adjourned, scrutiny non-sitting days etc.. along with whether each house is praying or not.

 * Calculuate sitting days during an interval

 * Documenting the different available periods

 * A guide to events, what to do a prorogation and dissolution etc

 * Checks around whether the synchronisatin processes are working or not

## What are the data sources?

The egg timer synchronises data from a few different sources:

* The [parliamentary periods and sessions spreadsheet](https://docs.google.com/spreadsheets/d/1e3AnQebAO5ug-Pc_0qDq9KkyZiy0dRhJMvm0lRRJOXk/edit?gid=0#gid=0) - this has two tabs

  * Parliament periods
  * Sessions

* The following public google calendars:

  * [Common's adjournment days calendar](https://calendar.google.com/calendar/embed?src=ikdqq0rcg07bbs64g7aeqqlkt4%40group.calendar.google.com&ctz=Europe%2FLondon
Commons)

  * [Common's sitting days calendar](https://calendar.google.com/calendar/embed?src=20n14bks46tvd2k5rse3jmsfb4%40group.calendar.google.com&ctz=Europe%2FLondon
Lords)

  * [Lord's adjournment days calendar](https://calendar.google.com/calendar/embed?src=ibbc1cen1mdm6rsf6kkno17i0c%40group.calendar.google.com&ctz=Europe%2FLondon
Lords)

  * [Lord's sitting days calendar](https://calendar.google.com/calendar/embed?src=o26tfi8b5o78cborja7utgpcb8%40group.calendar.google.com&ctz=Europe%2FLondon
Lords)

  * [Lord's virtual days calendar](https://calendar.google.com/calendar/embed?src=p1lfs3elv1fk0lqdigs3jngop8%40group.calendar.google.com&ctz=Europe%2FLondon
Commons) - the Lords continue to have virtual days, the Commons do not.

  * [Common's recess calendar](https://calendar.google.com/calendar/embed?src=eefeb6980f4ee93bd3d486b318141524452c82b[…]443a549e3c3%40group.calendar.google.com&ctz=Europe%2FLondon
Lords)

  * [Lord's recess calendar](https://calendar.google.com/calendar/embed?src=45591a2f31eb089019ba1b200e5ec635f8d25a9[…]b3165e714d4%40group.calendar.google.com&ctz=Europe%2FLondon)

These calendars are currently owned by ... using their own google account.

### Synchronisation

#### Database

A postgres database is used to store the calendar events for the website.

#### Calendar authorisation

The heroku app has an extra buildpack which does the following:

 * Read environment variables for `GOOGLE_CREDENTIALS`
 * Generate a temporary json on file on container start up, the name of the file being `GOOGLE_APPLICATION_CREDENTIALS`

 This then allows the following code to read the temporary json file and authorise against the API endpoint

```ruby
    scope = 'https://www.googleapis.com/auth/calendar'
    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('google-credentials.json'),
      scope: scope
    )
    authorizer.fetch_access_token!
```

#### Calendars

The calendars are synchronised using the simple ruby Google API client (RESTful). The 'modern' client does not provide a calendar endpoint. The simple endpoints are still supported by Google.

Authorisation is by using a standard google service account - this is the recommended way for using this ruby API.

The credentials are stored as Heroku environment variables and then, by using this buildpack, are made available pre-consumed for the application code.

The latest synchronisation date is stored, so that only entries *after* that date are added to the database.

#### Sessions and Parliamentary periods

These are imported from the CSV files in `db/data` using the [setup.rake](setup.rake) task

### Sync failures

There is a guide to resetting the database in [Prorogration and Dissolution](prorogation-and-dissolution.html.erb) or [online](https://api.parliament.uk/egg-timer/meta/prorogation-and-dissolution#resetting-the-database)

## Pulling db from Heroku

```heroku pg:pull DATABASE_URL parliament_calendar```

If you want to drop a local db first:

```dropdb parliament_calendar; heroku pg:pull DATABASE_URL parliament_calendar```

Using commentariat:

```ruby commentariat.rb -s lib/ -o demo```

... where "demo" is the output directory.