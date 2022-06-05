Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  
  get 'parliament-periods' => 'parliament#index', as: :parliament_list
  get 'parliament-periods/:parliament' => 'parliament#show', as: :parliament_show
  
  get 'dissolution-periods' => 'dissolution_period#index', as: :dissolution_period_list
  get 'dissolution-periods/:dissolution_period' => 'dissolution_period#show', as: :dissolution_period_show
  
  get 'sessions' => 'session#index', as: :session_list
  get 'sessions/:session' => 'session#show', as: :session_show
  
  get 'prorogation-periods' => 'prorogation_period#index', as: :prorogation_period_list
  get 'prorogation-periods/:prorogation_period' => 'prorogation_period#show', as: :prorogation_period_show
  
  get 'calendar' => 'calendar#index', as: :calendar_list
  get 'calendar/today' => 'calendar#today', as: :calendar_today
  get 'calendar/:year' => 'calendar#year', as: :calendar_year
  get 'calendar/:year/:month' => 'calendar#month', as: :calendar_month
  get 'calendar/:year/:month/:day' => 'calendar#day', as: :calendar_day
  
  get 'houses' => 'house#index', as: :house_list
  get 'houses/upcoming' => 'house#upcoming_all', as: :house_upcoming_all
  get 'houses/:house' => 'house#show', as: :house_show
  get 'houses/:house/upcoming' => 'house_days#upcoming', as: :house_days_upcoming
  get 'houses/:house/sitting-days' => 'house_days#sitting_day_list', as: :house_days_sitting_day_list
  get 'houses/:house/sitting-days/upcoming' => 'house_days#sitting_day_upcoming', as: :house_days_sitting_day_upcoming
  get 'houses/:house/sitting-days/upcoming/next' => 'house_days#sitting_day_next', as: :house_days_sitting_day_next
  get 'houses/:house/virtual-sitting-days' => 'house_days#virtual_sitting_day_list', as: :house_days_virtual_sitting_day_list
  get 'houses/:house/virtual-sitting-days/upcoming' => 'house_days#virtual_sitting_day_upcoming', as: :house_days_virtual_sitting_day_upcoming
  get 'houses/:house/virtual-sitting-days/upcoming/next' => 'house_days#virtual_sitting_day_next', as: :house_days_virtual_sitting_day_next
  get 'houses/:house/adjournment-days' => 'house_days#adjournment_day_list', as: :house_days_adjournment_day_list
  get 'houses/:house/adjournment-days/upcoming' => 'house_days#adjournment_day_upcoming', as: :house_days_adjournment_day_upcoming
  get 'houses/:house/adjournment-days/upcoming/next' => 'house_days#adjournment_day_next', as: :house_days_adjournment_day_next
  
  get 'calculator' => 'calculator#index', as: :calculator_form
  get 'calculator/:calculate' => 'calculator#calculate', as: :calculator_calculate
  
  get 'meta' => 'meta#index', as: :meta_list
  get 'meta/using' => 'meta#using', as: :meta_using
  get 'meta/calendar-sync' => 'meta#calendar_sync', as: :meta_calendar_sync
  get 'meta/prorogation-and-dissolution' => 'meta#prorogation_and_dissolution', as: :meta_prorogation_dissolution
  get 'meta/schema' => 'meta#schema', as: :meta_schema
  get 'meta/comments' => 'meta#comment', as: :meta_comment
  get 'meta/subscribe' => 'meta#subscribe', as: :meta_subscribe
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
