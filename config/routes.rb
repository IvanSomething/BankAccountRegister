Rails.application.routes.draw do
  resources :users
  resources :accounts, only: %i[create destroy]
end
