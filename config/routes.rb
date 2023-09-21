Rails.application.routes.draw do
  resources :lessons, except: [:new, :edit, :show, :destroy]
  get    '/lessons/new',     to: 'lessons#new',     as: 'new_lesson'
  post   '/lessons/create',  to: 'lessons#create',  as: 'create_lesson'
  get    '/lessons/edit',    to: 'lessosn#edit',    as: 'edit_lesson'
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