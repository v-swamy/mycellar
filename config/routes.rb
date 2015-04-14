Rails.application.routes.draw do
  root to: 'sessions#new'

  get 'ui(/:action)', controller: 'ui'

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/home', to: 'wines#index'

  resources :wines
  resources :users
end
