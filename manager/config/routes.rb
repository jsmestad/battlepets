Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show]
  resources :battlebots, only: [:index, :create]
end
