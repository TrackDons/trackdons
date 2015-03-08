Rails.application.routes.draw do
  root 'pages#root', as: :redirected_root

  if Rails.env.development?
    get '/sandbox' => 'sandbox#index'
    get '/sandbox/*template' => 'sandbox#show'
  end

  get 'auth/:service/callback', to: 'external_authentications#create'
  get 'auth/failure', to: 'external_authentications#failure'

  scope "/:locale" do
    root 'pages#index'

    get    'login'  => 'sessions#new'
    post   'login'  => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get    'signup(/:invitation_token)' => 'users#new', as: :signup

    get 'invite'  => 'invitations#new'
    post 'invite' => 'invitations#create'
    get 'invite/:invitation_token' => 'invitations#check', as: :check_invitation

    get 'about' => 'pages#about'

    resources :users

    resources :donations

    resources :projects do
      resources :donations
      member do
        patch 'follow'
        patch 'unfollow'
      end
    end

    resources :external_authentications, only: [:index, :edit, :update, :destroy]

    resources :password_resets, only: [:new, :create, :edit, :update]

    get 'projects(/*filters)' => 'projects#index', as: :projects_filtered
  end
end
