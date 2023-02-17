Rails.application.routes.draw do
  get 'film_planets/index'
  get 'film_planets/create'
  get 'film_planets/show'
  get 'film_planets/update'
  get 'film_planets/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :planets, only: %i[index create show update destroy]
  resources :films, only: %i[index create show update destroy]
  resources :people, only: %i[index create show update destroy]
  resources :film_people, only: %i[index create show update destroy]
  resources :film_planets, only: %i[index create show update destroy]
end
