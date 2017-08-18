Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks'}
  root 'exhibition#index'

  get 'exhibition/index'
  get '/calendar' =>'exhibition#calendar'
  get 'exhibition/magazine'
  get 'exhibition/magazine_index'
  get 'exhibition/magazine_show/:id' => 'exhibition#magazine_show'
  # get 'exhibition/han_index'
  # get 'exhibition/daerim_index'
  # get 'exhibition/seoul_index'
  # get 'exhibition/joong_index'
  post 'exhibition/magazine_create'
  get 'exhibition/magazine_edit/:id' => 'exhibition#magazine_edit'
  get 'exhibition/magazine_destroy/:id' => 'exhibition#magazine_destroy'
  post 'exhibition/magazine_update/:id' => 'exhibition#magazine_update'
  get 'exhibition/magazineRegister'


  get 'exhibition/location'
  get 'exhibition/test'
  get 'exhibition/keywordResult' => 'exhibition/keywordResult'
  get 'exhibition/locationResult' => 'exhibition/locationResult'
  get 'exhibition/main'
  post 'exhibition/main'
  post 'exhibition/create' => 'exhibition#create'
  get 'exhibition/registerForm' 
  get 'exhibition/show' => 'exhibition#show'
  get 'exhibition/show_detail/:id' => 'exhibition#show_detail'
  
  get 'exhibition/destroy/:id' => "exhibition#destroy" 
  post 'exhibition/:exhibition_id/like' =>'exhibition#like_toggle'
  post 'exhibition/reply_write' => 'exhibition#reply_write'
  
  get 'exhibition/liked_list' => 'exhibition#liked_list'
  get 'exhibition/reply_delete/:id' => 'exhibition#reply_delete'
  get 'exhibition/reply_update_view/:id' => 'exhibition#reply_update_view'
  post 'exhibition/reply_update/:id' => 'exhibition#reply_update'
  
  get 'exhibition/hashtag/:tagname' =>'exhibition#hashtags'
  get 'exhibition/liked_magazine'
  post 'exhibition/:post_id/like2' => 'exhibition#liked_magazine_toggle';
  

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
