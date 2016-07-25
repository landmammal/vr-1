Rails.application.routes.draw do

  resources :lesson_rehearsals
  # resources :lesson_rehearsals
  # resources :progresses
  resources :group_registrations
  resources :user_groups
  resources :groups
  root 'welcome#index'

  ['about','markets','process','contact'].each do |menu|
    get "/#{menu}" => "welcome##{menu}"
  end

  api_routes = ['courses','topics','lessons','course_registrations','site_panel','common_panel','instructor_panel']
  api_routes.each do |apir|
    get '/'+apir+'/api' => "api##{apir}_api"
    post '/'+apir+'/api' => "#{apir}#create"
  end


  get "/test" => "welcome#test"

  post '/topic/create' => "topics#create"
  post '/courses/:course_id/topics/:topic_id/lessons/new' => "lessons#create"




  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users




  resources :courses do
    collection do
      get '/search' => "courses#search"
    end
    resources :topics do
      resources :lessons
    end
  end

  resources :lessons, shallow: true do
    resources :explanations
    resources :prompts
    resources :models
    resources :concepts
    resources :rehearsals
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


  # resources :models
  # resources :explanations
  # resources :practices

  resources :demos
  resources :tasks

  # resources :lesson_concepts
  # resources :lesson_models
  # resources :lesson_prompts
  # resources :lesson_explanations
  # resources :topic_lessons
  # resources :course_topics
  # resources :course_registrations
end
