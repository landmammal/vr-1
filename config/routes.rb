Rails.application.routes.draw do

root 'welcome#index'

  welcome_routes = ['about','markets','process','contact']
  welcome_routes.each do |menu|
    get "/#{menu}" => "welcome##{menu}"
  end

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users

    resources :courses do 
      resources :topics do
        resources :lessons
      end
    end
  get '/allcourses' => "courses#all"
  post '/topic/create' => "topics#create"
  post '/courses/:course_id/topics/:topic_id/lessons/new' => "lessons#create"

  resources :courses do
    collection do
        get '/api' => "courses#course_api"
        get '/api/user_course' => "courses#user_course_api"
    end
  end

  resources :lessons do
    resources :practices, shallow: true do
      member do
        post :token
      end
    end
  end

  # resources :lessons do
  #   member do
  #     get 'prompt_view'
  #     get 'role_model_view'
  #     post 'prompt_token'
  #     post 'explanation_token'
  #     post 'role_model_token'
  #   end
  # end

  resources :concepts
  resources :models
  resources :prompts
  resources :explanations
  resources :practices
  resources :demos
  resources :tasks
  # resources :lesson_concepts
  # resources :lesson_models
  # resources :lesson_prompts
  # resources :lesson_explanations
  # resources :topic_lessons
  # resources :course_topics
  # resources :course_registrations

  get "/test" => "welcome#test"
  # get "/interfacetest" => "welcome#interface_test"

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
