Rails.application.routes.draw do
 
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  # API ROUTES

  # USER SIGN UP AND LOGIN ROUTES

  post 'users/register', to: 'users#user_register' # register a new leet user 
  post 'users/login', to: 'users#login' # user login to leet 
  get '/users', to: 'users#get_users' # get profile information for all users 
  get '/user', to: 'users#get_user' # get profile information for one user 
  delete '/user', to: 'users#delete_user' # delete a user 
  # put 'user/profile', to: 'users#update_user' # update information for a user

 # FLIGHT ROUTES

  post 'flights/create', to: 'flights#create_flight' # create a new flight 
  get 'flight/:id', to: 'flights#lookup_flight' # get information for a flight 
  put 'flight', to: 'flights#update_flight_info' # update flight information for user 
  delete 'flight/:id', to: 'flights#delete_user_flight' # delete flight information for a user 
  get 'flight/:id', to: 'flights#get_user_flight' # get flight information for a user

 # AIRPORT ROUTES

  post 'airport/create', to: 'airports#add_an_airport' # create a new airport 
  get 'airport/:id', to: 'airports#get_airport' # get information for an airport 
  get 'airports/all', to: 'airports#all' # get information for all airports
  
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

# HOMEPAGE

  root to: 'welcome#index'
end
