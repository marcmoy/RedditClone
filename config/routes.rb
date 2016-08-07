Rails.application.routes.draw do
  resources :users, only: [ :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]

  resources :posts, except: [ :index, :new, :destroy ] do
      resources :comments, only: [ :new ]
  end

  resources :subs do
    resources :posts, only: [:new, :destroy]
  end

  resources :comments, only: [ :create, :show ]

  root "subs#index"
end
