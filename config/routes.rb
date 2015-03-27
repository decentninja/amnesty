Amnesty::Application.routes.draw do
  get "static_pages/apidoc"

  resources :roles do
    member do
      post 'add_student'
      get 'remove_student'
      post 'add_position'
      get 'remove_position'
      post 'add_privilege'
      get 'remove_privilege'
    end
  end

  resources :students do
    member do
      post 'add_role'
      get 'remove_role'
      post 'add_privilege'
      get 'remove_privilege'
    end
    get 'have_privilege', on: :collection
  end

  resources :privileges do
    member do
      post 'add_role'
      get 'remove_role'
      post 'add_student'
      get 'remove_student'
    end
  end

  resources :positions do
    member do
      post 'add_role'
      get 'remove_role'
    end
  end

  get 'callback/:token', to: 'authentications#callback'
  get 'logout', to: 'authentications#logout', as: 'logout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'students#index'

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
