Rails.application.routes.draw do
  root 'pages#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'signup/:invitation_token'     => 'users#new', as: :signup # signup only by invitation
  
  get 'invite'     => 'invitations#new'
  post 'invite'    => 'invitations#create'
  get 'invite/:invitation_token'   => 'invitations#check', as: :check_invitation

  get 'pages/index'
  get 'about' => 'pages#about'

  #get 'users/:id'   => 'users#show', as: :user

  resources :users
  resources :donations
  resources :projects do
    resources :donations
  end
end
