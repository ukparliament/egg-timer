# egg-timer

Egg timer.

## Pulling db from Heroku

```heroku pg:pull DATABASE_URL parliament_calendar```

If you want to drop a local db first:

```dropdb parliament_calendar; heroku pg:pull DATABASE_URL parliament_calendar```

Using commentariat:

```ruby commentariat.rb -s lib/ -o demo```

... where "demo" is the output directory.