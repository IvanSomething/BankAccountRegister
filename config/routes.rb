# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :accounts, only: %i[create destroy]
  resources :transactions, param: :identification_number do
    post 'deposit', on: :member
    post 'transfer', on: :collection
  end
  resources :reports, only: :index
end
