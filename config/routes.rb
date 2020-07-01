Rails.application.routes.draw do
  get 'posts/ranking'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
  end

  root to: "tops#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
