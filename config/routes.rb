Rails.application.routes.draw do

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