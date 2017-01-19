Rails.application.routes.draw do
  resources :users, only: [:index, :create]
  resources :battlebots, only: [:index, :create]
end
