Rails.application.routes.draw do
  root    'sessions#new'
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'
  resources :master, only: :index
  resources :books_all, only: [:index]
  resources :users do
  resources :books, only: [:index,:create,:destroy,:show] do
    get :search, on: :collection
  end
  resources :homes, only: [:index,:create,:destroy]
  end

end

