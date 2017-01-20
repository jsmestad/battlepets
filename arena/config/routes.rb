Rails.application.routes.draw do
  resources :contests, only: [:index, :create, :show]
end
