Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #home page
  root 'pages#home'
  #about page
  get 'about', to: 'pages#about'
  #articles
  resources :articles
  #users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  #session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
