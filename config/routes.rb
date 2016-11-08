Rails.application.routes.draw do
  # landing page
  root 'welcome#index'
  resources :performance_feedbacks

  # routes for menu
  menu_routes = ['about','markets','overview','process','contact','versions']
  menu_routes.push('theteam','termsandservices','FAQs','requirements','policies','press','teach','coach','learn','create','support')
  menu_routes.each do |menu|
    get "/#{menu}" => "welcome##{menu}"
  end

  # api routes
  api_routes = ['courses','topics','lessons','course_registrations','site_panel','common_panel','instructor_panel','admin_panel']
  api_routes.push('demos','tasks','chat')
  api_routes.push('rehearsals', 'feedbacks', 'group')
  api_routes.each do |apir|
    get '/'+apir+'/api' => "api##{apir}_api"
    post '/'+apir+'/api' => "#{apir}#create"
    get '/'+apir+'/:id/api' => "api##{apir}_single_api"
    put '/'+apir+'/:id/api' => "#{apir}#update"
  end
  get "/display_course/:id" => "courses#display"
  get "/new_termsandservices" => "welcome#reviewtermsandservices"
  post "/accepttermsandservices" => "welcome#accepttermandservices"
  post "/courses_search/api" => "api#courses_search_api"


  put '/rehearsal/:rehearsal_id/rehearsal_approved' => "rehearsals#rehearsal_approved"

  get "/test" => "welcome#test"
  get "/lessonexp/" => "lesson_explanations#index"

  post '/topic/create' => "topics#create"
  post '/courses/:course_id/topics/:topic_id/lessons/new' => "lessons#create"
  post '/group_registrations/group/:id' => 'group_registrations#create'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users do
    resources :groups do
      resources :user_groups
      resources :group_registrations
    end
  end


  resources :courses do
    resources :course_registrations
    collection do
      get '/search' => "courses#search"
    end
    resources :topics do
      resources :lessons
    end
  end

  get "/course_registrations/" => "course_registrations#index"
  get "/rehearsals/all" => "rehearsals#all"
  get "/feedback/all" => "feedbacks#all"
  get "/groups/all_groups" => "groups#all_groups"
  get '/groups/:id' => 'groups#my_group'
  get '/group_registrations/group/:id' => 'group_registrations#registrations'

  resources :lessons, shallow: true do
    resources :explanations
    resources :prompts
    resources :models
    resources :concepts
    resources :rehearsals do
      resources :feedbacks
    end
  end


  resources :lessons do
    resources :practices, shallow: true do
      member do
        post :token
      end
    end
  end

  resources :demos
  resources :tasks
  # resources :models
  # resources :explanations
  # resources :practices
  # resources :group_registrations
  # resources :course_registrations
  # resources :user_groups2
  # resources :course_topics
  # resources :topic_lessons
  # resources :lesson_concepts
  # resources :lesson_models
  # resources :lesson_prompts
  # resources :lesson_explanations
  # resources :lesson_rehearsals
end
