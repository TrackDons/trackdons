Rails.application.routes.draw do
  root 'pages#root', as: :redirected_root

  scope "/:locale" do
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

    resources :users
    resources :donations
    resources :projects do
      resources :donations
    end

    get 'projects(::category)' => 'projects#index', as: :category
  end
end
