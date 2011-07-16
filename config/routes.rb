Vidli::Application.routes.draw do
  resources :s3_uploads

  root :to => "home#index"
  
  ## VIDEOS
  match 'videos/show/:id', :to => 'videos#show', :as => 'show_video'
  match 'videos/search', :to => 'videos#search', :as => 'search_videos'
  match 'videos/search/:q', :to => 'videos#search', :as => 'query_search_videos'
  match 'videos/watch', :to => 'videos#watch', :as => 'watch_videos'
  match 'videos/download', :to => 'videos#download', :as => 'download_videos'

  ## CART
  match 'cart', :to => 'cart#index', :as => 'cart'
  match 'cart/add/download/:id', :to => 'cart#add', :delivery => 'download', :as => 'add_download_cart'
  match 'cart/add/streaming/:id', :to => 'cart#add', :delivery => 'streaming', :as => 'add_streaming_cart'
  match 'cart/remove/:id', :to => 'cart#remove', :as => 'remove_cart_item'

  ## CHECKOUT
  match 'checkout/express', :to => 'checkout#express', :as => 'express_checkout'
  match 'checkout/confirm', :to => 'checkout#confirm', :as => 'confirm_checkout'
  match 'checkout/place_order', :to => 'checkout#place_order', :as => 'place_order_checkout'

  ## ORDERS
  resources :orders
  match 'orders/download/:id/:order_item_id', :to => 'orders#download', :as => 'download_order_item'
  match 'orders/streaming/:id/:order_item_id', :to => 'orders#streaming', :as => 'streaming_order_item'
  match 'orders/watch/:id/:order_item_id', :to => 'orders#watch', :as => 'watch_order_item'
  
  ## USERS
  resources :users do
    member do
      get "register"
    end
  end
  match 'register' => "users#new", :as => :register
  match 'account' => "users#show", :as => :account
  put 'reset_password/:reset_password_code' => 'users#reset_password_submit', :as => :reset_password, :via => :put
  get 'reset_password/:reset_password_code' => 'users#reset_password', :as => :reset_password, :via => :get
  
  ## USER SESSIONS
  resources :user_sessions
  get "user_sessions/new"

  match 'login' => "user_sessions#new", :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'forgot_password' => 'user_sessions#forgot_password', :as => :forgot_password, :via => :get
  match 'forgot_password' => 'user_sessions#forgot_password_lookup_email', :as => :forgot_password, :via => :post

  ## ADMIN
  namespace :admin do
    # (app/controllers/admin/products_controller.rb)
    root :to => "videos#index"
    resources :videos do
      member do
        post 'update_s3_path'
        get 'delete_s3_asset'
      end
    end
    
    resources :orders
    
    resources :users do
      member do
        post "update_roles"
      end
    end
  end

# match ':controller(/:action(/:id))'

#  match ':controller(/:action(/:id))', :controller => /admin\/[^\/]+/

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
