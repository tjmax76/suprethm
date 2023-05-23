Rails.application.routes.draw do
  
  devise_for :users
  root to: "homes#index"
  resources :users, only: :show
  resources :chronos, only: :index
end
