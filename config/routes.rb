Rails.application.routes.draw do
  
  # My Api
  get 'jsoners/ghana/:currency/:money' => 'jsoners#ghana'

  get 'admin' => 'admins#index'
  get 'admin/show/:id' => 'admins#show', as: 'show_admin'
  get 'admin/pending' => 'admins#pending'
  get 'admin/past' => 'admins#past'
  post 'admin/approve' => 'admins#approve'

 # Signup Routes
  get 'members/index'
  get 'members/new'
  post 'members/create'

  # Email Verifications and sending
  get 'registrations/fresher'

  # Signin Routes
  get 'sessions/new'
  get  'sessions/destroy'
  post 'sessions/create'

  
  # Dashboard Routes
  get 'dashboard/index'
  get 'dashboard/transactions'
  get 'dashboard/settings'
  post 'dashboard/create'
  post 'dashboard/details_update'
  post 'dashboard/email_update'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  root 'cras#index'
  resources :charges

  
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
