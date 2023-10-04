Rails.application.routes.draw do
  get    '/enrolments/new',     to: 'enrolments#new',        as: 'new_enrolment'
  post   '/enrolments/create',  to: 'enrolments#create',     as: 'create_enrolment'
  get    '/enrolments/delete',  to: 'enrolments#del_fake',   as: 'delete_fake'
  delete '/enrolments/destroy', to: 'enrolments#destroy',    as: 'destroy_enrolment'
  get    '/enrolments/status',  to: 'enrolments#see_status', as: 'see_status'
  get    '/enrolments/sstatus', to: 'enrolments#one_status', as: 'one_status'
  post   '/enrolments/status',  to: 'enrolments#set_status', as: 'set_status'

  resources :answers, except: [:destroy]
  post   '/answers/create',  to: 'answer#create',   as: 'create_answer'
  patch  '/answers/update',  to: 'answer#update',   as: 'update_answer'
  delete '/answers/destroy', to: 'answers#destroy', as: 'destroy_answer'
  
  resources :assessments, except: [:new, :edit, :show, :destroy]
  get    '/assessments/new',         to: 'assessments#new',         as: 'new_assessment'
  post   '/assessments/create',      to: 'assessments#create',      as: 'create_assessment'
  get    '/assessments/list',        to: 'assessments#list',        as: 'list_quizzes'
  get    '/assessments/results',     to: 'assessments#results',     as: 'quiz_results'
  get    '/assessments/edit',        to: 'assessments#edit',        as: 'edit_assessment'
  patch  '/assessments/update',      to: 'assessments#update',      as: 'update_assessment'
  delete '/assessments/destroy',     to: 'assessments#destroy',     as: 'destroy_assessment'
  get    '/assessments/show',        to: 'assessments#show',        as: 'show_assessment'

  get    '/assessments/new_quiz',    to: 'assessments#new_quiz',    as: 'new_quiz'
  post   '/assessments/create_quiz', to: 'assessments#create_quiz', as: 'create_quiz'
  get    '/assessments/show_quiz',   to: 'assessments#show_quiz',   as: 'show_quiz'
  get    '/assessments/review_quiz', to: 'assessments#review_quiz', as: 'review_quiz'
  get    '/assessments/take_quiz',   to: 'assessments#take_quiz',   as: 'take_quiz'
  post   '/assessments/submit_quiz', to: 'assessments#submit_quiz', as: 'submit_quiz'
  get    '/assessments/new_test',    to: 'assessments#new_test',    as: 'new_test'
  post   '/assessments/add_qp',      to: 'assessments#add_paper',   as: 'add_question_paper'
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
  get    '/courses/pending', to: 'courses#pending', as: 'pending'

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

  5 the Joy belonging co
  5 So good planetshakers
  
  8  Lord of my life
  5  Here is my heart
  6  You will be saved
  12 More of You
  8  Been so good
  8  Fear is not my future
  8  You really are
  11 Costly
  9  One name
  9  More than Able
  9  Firm Foundation
  5  Jehovah
  6  Yahweh
  7  Yahweh will Manifest
  7  Yeshua
  10 Who is this man?
   5 Praise (Elevation)
  7  Welcome Resurrection (Elevation)
  9  Show me your Glory
  6  Crowned (highlands worship, Rebecca Hart)
  4  All hail the Power of Jesus name

  12 most beautiful (Greatest Father, Closest Friend)
  Lex de Azevdo
=end