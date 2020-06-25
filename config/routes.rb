Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/ranking'
  get 'posts/show'
  get 'posts/create'
  get 'posts/edit'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show]

  root to: "tops#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
