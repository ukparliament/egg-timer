Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get '/' => 'home#index'

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'egg-timer' => 'home#index', as: :home
  
  # Calculators
  get 'egg-timer/calculators' => 'calculator#index', as: :calculator_list
  get 'egg-timer/calculator' => 'calculator#scrutiny_period', as: :calculator_form
  get 'egg-timer/calculator/calculate' => 'calculator#calculate', as: :calculator_calculate
  get 'egg-timer/calculator/interval' => 'calculator#interval', as: :calculator_interval
  get 'egg-timer/calculator/interval/calculate' => 'calculator#interval_calculate', as: :calculator_interval_calculate
  get 'egg-timer/calculator/styles' => 'calculator#style', as: :calculator_style_form
  
  # Parliamentary time
  get 'egg-timer/time-periods' => 'parliamentary_time#index', as: :parliamentary_time_list
  
  get 'egg-timer/parliament-periods' => 'parliament#index', as: :parliament_list
  get 'egg-timer/parliament-periods/:parliament' => 'parliament#show', as: :parliament_show
  
  get 'egg-timer/dissolution-periods' => 'dissolution_period#index', as: :dissolution_period_list
  get 'egg-timer/dissolution-periods/:dissolution_period' => 'dissolution_period#show', as: :dissolution_period_show
  
  get 'egg-timer/sessions' => 'session#index', as: :session_list
  get 'egg-timer/sessions/:session' => 'session#show', as: :session_show
  
  get 'egg-timer/prorogation-periods' => 'prorogation_period#index', as: :prorogation_period_list
  get 'egg-timer/prorogation-periods/:prorogation_period' => 'prorogation_period#show', as: :prorogation_period_show
  
  # Houses
  get 'egg-timer/houses' => 'house#index', as: :house_list
  get 'egg-timer/houses/upcoming' => 'house#upcoming_all', as: :house_upcoming_all
  get 'egg-timer/houses/:house' => 'house#show', as: :house_show
  
  get 'egg-timer/houses/:house/upcoming' => 'house_days#upcoming', as: :house_days_upcoming
  get 'egg-timer/houses/:house/sitting-days' => 'house_days#sitting_day_list', as: :house_days_sitting_day_list
  get 'egg-timer/houses/:house/sitting-days/upcoming' => 'house_days#sitting_day_upcoming', as: :house_days_sitting_day_upcoming
  get 'egg-timer/houses/:house/sitting-days/upcoming/next' => 'house_days#sitting_day_next', as: :house_days_sitting_day_next
  get 'egg-timer/houses/:house/sitting-days/preceding' => 'house_days#sitting_day_preceding', as: :house_days_sitting_day_preceding
  get 'egg-timer/houses/:house/sitting-days/preceding/latest' => 'house_days#sitting_day_latest', as: :house_days_sitting_day_latest
  get 'egg-timer/houses/:house/virtual-sitting-days' => 'house_days#virtual_sitting_day_list', as: :house_days_virtual_sitting_day_list
  get 'egg-timer/houses/:house/virtual-sitting-days/upcoming' => 'house_days#virtual_sitting_day_upcoming', as: :house_days_virtual_sitting_day_upcoming
  get 'egg-timer/houses/:house/virtual-sitting-days/upcoming/next' => 'house_days#virtual_sitting_day_next', as: :house_days_virtual_sitting_day_next
  get 'egg-timer/houses/:house/virtual-sitting-days/preceding' => 'house_days#virtual_sitting_day_preceding', as: :house_days_virtual_sitting_day_preceding
  get 'egg-timer/houses/:house/virtual-sitting-days/preceding/latest' => 'house_days#virtual_sitting_day_latest', as: :house_days_virtual_sitting_day_latest
  get 'egg-timer/houses/:house/adjournment-days' => 'house_days#adjournment_day_list', as: :house_days_adjournment_day_list
  get 'egg-timer/houses/:house/adjournment-days/upcoming' => 'house_days#adjournment_day_upcoming', as: :house_days_adjournment_day_upcoming
  get 'egg-timer/houses/:house/adjournment-days/upcoming/next' => 'house_days#adjournment_day_next', as: :house_days_adjournment_day_next
  get 'egg-timer/houses/:house/adjournment-days/preceding' => 'house_days#adjournment_day_preceding', as: :house_days_adjournment_day_preceding
  get 'egg-timer/houses/:house/adjournment-days/preceding/latest' => 'house_days#adjournment_day_latest', as: :house_days_adjournment_day_latest
  get 'egg-timer/houses/:house/recess-dates' => 'house_days#recess_dates', as: :house_days_recess_dates_list
  get 'egg-timer/houses/:house/recess-dates/upcoming' => 'house_days#recess_dates_upcoming', as: :house_days_recess_dates_upcoming
  
  # Calendar
  get 'egg-timer/calendar' => 'calendar#index', as: :calendar_list
  get 'egg-timer/calendar/today' => 'calendar#today', as: :calendar_today
  get 'egg-timer/calendar/:year' => 'calendar#year', as: :calendar_year
  get 'egg-timer/calendar/:year/:month' => 'calendar#month', as: :calendar_month
  get 'egg-timer/calendar/:year/:month/:day' => 'calendar#day', as: :calendar_day
  
  # About pages
  get 'egg-timer/meta' => 'meta#index', as: :meta_list
  get 'egg-timer/meta/using' => 'meta#using', as: :meta_using
  get 'egg-timer/meta/schema' => 'meta#schema', as: :meta_schema
  get 'egg-timer/meta/comments' => 'meta#comment', as: :meta_comment
  get 'egg-timer/meta/subscribe' => 'meta#subscribe', as: :meta_subscribe
  get 'egg-timer/meta/app' => 'meta#app', as: :meta_app
  
  # Librarian tools
  get 'egg-timer/meta/librarian-tools' => 'meta#librarian_tools', as: :meta_librarian_tools
  get 'egg-timer/meta/calendar-sync' => 'meta#calendar_sync', as: :meta_calendar_sync
  get 'egg-timer/meta/prorogation-and-dissolution' => 'meta#prorogation_and_dissolution', as: :meta_prorogation_dissolution
  get 'egg-timer/meta/recess-checker' => 'meta#recess_checker', as: :meta_recess_checker
  get 'egg-timer/meta/detailed-sync-logs' => 'meta#detailed_sync_logs', as: :meta_detailed_sync_logs
  
  # Unlinked to
  get 'egg-timer/meta/calendar-sync-checker' => 'meta#calendar_sync_checker', as: :meta_calendar_sync_checker
end
