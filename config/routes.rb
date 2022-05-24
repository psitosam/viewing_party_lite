Rails.application.routes.draw do

  # get '/', to: 'landing#index'
  root 'landing#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  resources :users, only: [:create, :show] do
    resources :movies, only: [:index, :show] do
      resources :parties, only: [:new, :create]
    end
    get '/dashboard', to: 'users#show'
    post '/dashboard', to: 'users#show'
    get '/discover', to: 'users#discover'
  end
end
