Yobi2::Application.routes.draw do

  root :to => "home#index"

  devise_for :users
  get '/users/account' => "users#show", :as => :account  
  get '/articles/:url' => "articles#show", :as => :article_url
  get '/products/:url' => "products#show", :as => :product_url
  get '/categories/:url' => "categories#show", :as => :category_url
  get "/search" => "home#search", :as => :search
  get '/articles' => "articles#index", :as => :articles
  get '/categories' => "categories#index", :as => :categories
  get '/tags/:tag' => "home#tags", :as => :tags
  
  namespace :admin do
    root :to => "home#index"
    resources :articles do
      resources :article_images, :as => :images, :only => [:create, :update, :destroy]
    end
    resources :products do
      get 'destroy_confirm', :on => :member
      put 'toggle_elite', :on => :member
      resources :product_images, :as => :images, :only => [:create, :update, :destroy]
    end
    resources :categories do
    	post :sort, :on => :collection
    	resources :category_images, :as => :images, :only => [:create, :update, :destroy]
    end
    resources :plists, :except => :show
    resources :product_images, :as => :pimages, :only => [:index, :destroy]
    resources :category_images, :as => :cimages, :only => [:index, :destroy]
    resources :article_images, :as => :aimages, :only => [:index, :destroy]
    resources :slides, :except => :show
    resources :users
    match "/generate_sitemap" => "home#generate_sitemap"
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
