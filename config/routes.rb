Rails.application.routes.draw do
  resources :answers, except: [:destroy]
  post   '/answers/create',  to: 'answer#create',   as: 'create_answer'
  patch  '/answers/update',  to: 'answer#update',   as: 'update_answer'
  delete '/answers/destroy', to: 'answers#destroy', as: 'destroy_answer'

  resources :questions, except: [:new, :destroy]
  # get    '/question/new',     to: 'questions#new',     as: 'new_questions'
  # post   '/question/create',  to: 'questions#create',  as: 'create_questions'
  patch  '/question/update',  to: 'questions#update',  as: 'update_question'
  delete '/question/destroy', to: 'questions#destroy', as: 'destroy_question'
  
  resources :quizzes, except: [:new, :edit, :destroy]
  # get    '/quiz/new',     to: 'quizzes#new',     as: 'new_quiz_bruh'
  # post   '/quiz/create',  to: 'quizzes#create',  as: 'create_quiz_bruh'
  get    '/quiz/edit',    to: 'quizzes#edit',    as: 'edit_quizz'  
  patch  '/quiz/update',  to: 'quizzes#update',  as: 'update_quiz' 
  delete '/quiz/destroy', to: 'quizzes#destroy', as: 'destroy_quiz'

  resources :assessments, except: [:new, :edit, :show, :destroy]
  get    '/assessments/new',         to: 'assessments#new',         as: 'new_assessment'
  post   '/assessments/create',      to: 'assessments#create',      as: 'create_assessment'
  get    '/assessments/edit',        to: 'assessments#edit',        as: 'edit_assessment'
  patch  '/assessments/update',      to: 'assessments#update',      as: 'update_assessment'
  delete '/assessments/destroy',     to: 'assessments#destroy',     as: 'destroy_assessment'

  get    '/assessments/new_quiz',    to: 'assessments#new_quiz',    as: 'new_quiz'
  post   '/assessments/create_quiz', to: 'assessments#create_quiz', as: 'create_quiz'
  get    '/assessments/show_quiz',   to: 'assessments#show_quiz',   as: 'show_quiz'
  get    '/assessments/review_quiz', to: 'assessments#review_quiz', as: 'review_quiz'
  get    '/assessments/take_quiz',   to: 'assessments#take_quiz',   as: 'take_quiz'
  post   '/assessments/submit_quiz', to: 'assessments#submit_quiz', as: 'submit_quiz'
  get    '/assessments/question',    to: 'assessments#new_question',     as: 'new_question'
  post   '/assessments/question',    to: 'assessments#create_question',  as: 'create_question'

  resources :lessons, except: [:new, :edit, :show, :destroy]
  get    '/lessons/new',     to: 'lessons#new',     as: 'new_lesson'
  post   '/lessons/create',  to: 'lessons#create',  as: 'create_lesson'
  get    '/lessons/edit',    to: 'lessons#edit',    as: 'edit_lesson'
  patch  '/lessons/update',  to: 'lessons#update',  as: 'update_lesson'
  get    '/lessons/show',    to: 'lessons#show',    as: 'show_lesson'
  get    '/lessons/list',    to: 'lessons#list',    as: 'list_lessons'
  delete '/lessons/destroy', to: 'lessons#destroy', as: 'destroy_lesson'

  resources :courses, except: [:new, :edit, :show, :destroy]
  get    '/courses/new',     to: 'courses#new',     as: 'new_course'
  post   '/courses/create',  to: 'courses#create',  as: 'create_course'
  get    '/courses/show',    to: 'courses#show',    as: 'show_course'
  get    '/courses/list',    to: 'courses#list',    as: 'list_courses'
  get    '/courses/edit',    to: 'courses#edit',    as: 'edit_course'
  patch  '/courses/update',  to: 'courses#update',  as: 'update_course'
  delete '/courses/destroy', to: 'courses#destroy', as: 'destroy_course'

  get    '/sessions/new',     to: 'sessions#new',     as: 'new_user_session'
  post   '/sessions/create',  to: 'sessions#create',  as: 'login'
  delete '/sessions/destroy', to: 'sessions#destroy', as: 'logout'

  resources :users, except: [:new, :edit, :show, :destroy]

  get    '/registrations/new',     to: 'users#new',     as: 'new_user'
  post   '/registrations/create',  to: 'users#create',  as: 'create_user'
  get    '/registrations/show',    to: 'users#show',    as: 'show_user'
  get    '/registrations/edit',    to: 'users#edit',    as: 'edit_user'
  patch  '/registrations/update',  to: 'users#update',  as: 'update_user'
  delete '/registrations/destroy', to: 'users#destroy', as: 'destroy_user'

  get '/about', to: 'about#new'
  root          to: 'home#new'

end

=begin

  the Joy belonging co
  So good planetshakers

  Lord of my life
  Here is my heart
  You will be saved
  Been so good
  Fear is not my future
  You really are
  Costly
  One name
  More than Able
  Firm Foundation
  Jehovah
  Yahweh
  Yahweh will Manifest
  Yeshua
  Who is this man?
  Praise (Elevation)
  Welcome Resurrection (Elevation)
  Show me your Glory
  Crowned (highlands worship, Rebecca Hart)
  All hail the Power of Jesus name

=end