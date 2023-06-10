Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/:chrono_id/sign_up', to: 'devise/registrations#new'
    post '/:chrono_id/sign_up', to: 'devise/registrations#create'
  end

  root to: "homes#index"
  resources :users, only: :show do
    resources :diaries
    resources :schedules, only: [:new, :create, :index, :destroy]
  end
  resources :chronos, only: [:index, :create, :new, :show]
end
