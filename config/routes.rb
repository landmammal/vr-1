Rails.application.routes.draw do


  resources :tasks

  root 'welcome#index'
  resources :practices

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users

    resources :courses do
      resources :chapters, shallow: true do
        resources :lessons, shallow: true
      end
    end

  resources :lessons do
    resources :practices, shallow: true
  end

  resources :lessons do
    member do
      get 'prompt_view'
      get 'role_model_view'
      post 'prompt_token'
      post 'explanation_token'
      post 'role_model_token'
    end
  end



  get "/test" => "welcome#test"
  get "/interfacetest" => "welcome#interface_test"

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


end
