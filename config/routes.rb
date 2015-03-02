Rails.application.routes.draw do
  root 'pages#root', as: :redirected_root

  get 'auth/:service/callback', to: 'external_authentications#create'
  get 'auth/failure', to: 'external_authentications#failure'

  scope "/:locale" do
    root 'pages#index'

    get    'login'  => 'sessions#new'
    post   'login'  => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
    get    'signup' => 'users#new', as: :signup # signup only by invitation

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
