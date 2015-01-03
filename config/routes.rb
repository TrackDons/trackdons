Rails.application.routes.draw do
  root 'pages#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'signup' => 'users#new'

  get 'pages/index'
  get 'about' => 'pages#about'

  resources :users
  resources :donations
  resources :projects do
    resources :donations
  end
end
