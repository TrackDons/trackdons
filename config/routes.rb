Rails.application.routes.draw do
  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

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

    get 'projects-:category' => 'projects#index', as: :category
    post 'projects/:id/edit' => 'projects#update' 
    post 'projects/new' => 'projects#create' 

  end
  
end
