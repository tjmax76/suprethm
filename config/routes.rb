Rails.application.routes.draw do
  
  get '/users/:chrono_id/sign_up', to: 'devise/registrations#new', as: :new_user_signup
  devise_for :users
  root to: "homes#index"
  resources :users, only: :show
  resources :chronos, only: [:index, :create, :new]
  
end
