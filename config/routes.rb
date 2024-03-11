Rails.application.routes.draw do

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  # Implement Nested Comments
  delete 'logout', to: 'sessions#destroy', as: :logout


  root 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'index', to: 'static_pages#index'

  get 'profile', to: 'users#profile'

  resources :posts
  resources :users do
    get 'profile', on: :member
  end

  resources :posts do
    resources :comments, only: [:create, :new, :destroy]
  end

end
