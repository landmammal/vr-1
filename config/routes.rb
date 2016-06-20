Rails.application.routes.draw do
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

end
