Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_models, only: %i[show new create]
  resources :subsidiaries, only: %i[show new create]
  resources :cars, only: %i[show new create]
  resources :manufactures, only: %i[new create show edit update index]
end
