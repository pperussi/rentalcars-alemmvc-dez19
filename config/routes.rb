Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_models, only: %i[show new create edit index update]
  resources :subsidiaries, only: %i[show new create edit index update]
  resources :cars, only: %i[show new create]
  resources :manufactures, only: %i[new create show edit update index]
  resources :fuel_type, only: %i[show new create]
  resources :clients, only: %i[show new create]
  resources :individual_clients, only: %i[show new create index edit update]
  resources :corporate_clients, only: %i[show new create index edit update]
end
