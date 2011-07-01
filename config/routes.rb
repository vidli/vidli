Vidli::Application.routes.draw do
  get "users/register"

  get "user_sessions/new"

  resources :s3_uploads

  root :to => "home#index"
  
  namespace :admin do
    # (app/controllers/admin/products_controller.rb)
    root :to => "videos#index"
    resources :videos do
      member do
        post 'update_s3_path'
        get 'delete_s3_asset'
      end
    end
  end

  match 'cart', :to => 'cart#index', :as => 'cart'
  match 'videos/show/:id', :to => 'videos#show', :as => 'show_video'
  match 'cart/add/download/:id', :to => 'cart#add', :delivery => 'download', :as => 'add_download_cart'
  match 'cart/add/streaming/:id', :to => 'cart#add', :delivery => 'streaming', :as => 'add_streaming_cart'
  match 'cart/remove/:id', :to => 'cart#remove', :as => 'remove_cart_item'

  resources :user_sessions
  
  resources :users do
    member do
      post "update_roles"
    end
  end

  match 'login' => "user_sessions#new", :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'register' => "users#new", :as => :register
  match 'account' => "users#show", :as => :account

  match ':controller(/:action(/:id))'

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
