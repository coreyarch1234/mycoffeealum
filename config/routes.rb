Rails.application.routes.draw do
  resources :tags
  get 'tag/:tag', to: 'users#index', as: :tag_user

  resources :conversations do
      resources :messages
  end

  devise_for :users, :path => 'u', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  get 'static/home'
  resources :users, except: [:new, :create]

  authenticated :user do
    root :to => 'users#index', as: :authenticated_root
  end
  root :to => 'static#home'
end
