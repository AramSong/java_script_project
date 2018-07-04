Rails.application.routes.draw do
  devise_for :users
  root 'movies#index'
  resources :movies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/likes/:movie_id' => 'movies#like_movie'
end
