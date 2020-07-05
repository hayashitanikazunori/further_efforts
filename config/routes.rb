Rails.application.routes.draw do
  get 'users/ranking'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show]
  resources :posts

  root to: "tops#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
