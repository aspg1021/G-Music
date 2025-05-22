Rails.application.routes.draw do
  root "songs#index"

  resources :songs do
    resource :favorite, only: [:create, :destroy]
  end
  
  get '/users/:id/songs', to: 'songs#user_index', as: 'user_songs'
  get '/favorites', to: 'favorites#index', as: 'favorites'
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
