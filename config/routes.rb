Rails.application.routes.draw do

  # landing page
  root 'welcome#index'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # MENU LINKS
  menu_routes = [
    'about','markets','overview','process','contact','versions','jobs',
    'theteam','termsandservices','FAQs','requirements','policies','press',
    'teach','coach','learn','create','companies','support'
  ]
  menu_routes.each do |menu|
    get "/#{menu}" => "welcome##{menu}"
  end

  # API routes
  api_routes = [
    'courses','topics','lessons','course_registrations',
    'site_panel','common_panel','instructor_panel',
    'admin_panel','demos','tasks','chat',
    'rehearsals', 'feedbacks', 'group', 'reviewrehearsal'
  ]
  api_routes.each do |apir|
    get '/'+apir+'/api' => "api##{apir}_api"
    post '/'+apir+'/api' => "#{apir}#create"
    get '/'+apir+'/:id/api' => "api##{apir}_single_api"
    put '/'+apir+'/:id/api' => "#{apir}#update"
  end
  

  # EXTRA LINKS ------

      get "/rehearsals/student" => "rehearsals#student"
      get "/rehearsals/all" => "rehearsals#all"
      
      get "/feedback/all" => "feedbacks#all"
      
      # COURSE LINKS
      post "/courses_search/api" => "api#courses_search_api"
      post '/courses/:course_id/topics/:topic_id/lessons/new' => "lessons#create"
      get "/course_registrations/" => "course_registrations#index"
      post "/email_exits" => "users#email_exits"
      post "/leave_course" => "courses#leave_course"
      post "/remove_student" => "courses#remove_student"
      post "/activate_deactivate_student" => "courses#activate_deactivate_student"
      post "/reentry/:id/" => "courses#reentry"
      
      # COURSE INVITATIONS
      get "/generate_course_code/" => "courses#generate_code"
      post "/invite_student/" => "courses#send_invite"
      post "/register_with_access_code" => "courses#register_with_access_code"
      get "/courses/:course_id/accept_invitation/" => "courses#accept_invitation"
      get "/courses/:course_id/accept_invitation/:user_id" => "courses#accept_invitation"

      post '/topic/create' => "topics#create"

      get '/group_registrations/group/:id' => 'group_registrations#registrations'
      post '/group_registrations/group/:id' => 'group_registrations#create'
      get "/groups/all_groups" => "groups#all_groups"
      get '/groups/:id' => 'groups#my_group'
      
      # OTHER LINKS
      post "/users/course_list_nav" => "users#course_list_nav"
      post "/courses/student_list_nav" => "courses#student_list_nav"
      get "/change_first_contact" => "users#change_first_contact"
      post "/job_application" => "welcome#job_application"
      get "/test" => "welcome#test"
      get "/reset" => "welcome#reset"
      get "/lessonexp/" => "lesson_explanations#index"
      get "/display_course/:id" => "courses#display"
      get "/new_termsandservices" => "welcome#reviewtermsandservices"
      post "/accepttermsandservices" => "welcome#accepttermandservices"
  
  # EXTRA LINKS ------ END


  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users do
    resources :groups do
      resources :user_groups
      resources :group_registrations
    end
    collection do
      post 'batch_update' => "users#batch_update"
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

  
  # routes for purchases
  resources :charges
  resources :purchases, only: [:show]

  resources :peer_reviews
  resources :review_requests do
    resources :peer_reviews
  end
  resources :demos
  resources :tasks
  resources :performance_feedbacks
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
