Rails.application.routes.draw do
  get 'users/ranking'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :users, only: [:show] do
    member do
      get :followings, :followers
    end
  end
  resources :follow_relationships, only: [:create, :destroy]
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  root to: "tops#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
