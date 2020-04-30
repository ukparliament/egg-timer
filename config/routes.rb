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
