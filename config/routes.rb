Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :planets, only: %i[index create show update destroy]
  resources :films, only: %i[index create show update destroy]
  resources :people, only: %i[index create show update destroy]
  resources :film_people, only: %i[index create show update destroy]
  resources :film_planets, only: %i[index create show update destroy]
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
end
