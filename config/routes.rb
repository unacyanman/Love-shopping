Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 管理者機能
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  
  namespace :public do
    resources :posts do
      resources :comments, only: [:create, :edit, :show, :destroy]
    end
  end
  
  namespace :public do
    resources :users, only: [:edit, :update]
    
  end
  

  scope module: :public do
    devise_for :users
    resources :users
    root to: 'homes#top', as: 'homes'
    get 'homes/about', to: 'homes#about', as: 'about'
    get "search" => "searches#search"
    get 'posts/new'
    get 'top', to: 'homes#top'
    post 'posts' => 'posts#create'
    get 'posts' => 'posts#index'
    get 'posts/:id' => 'posts#show', as: 'post'
    get 'posts/:id/edit' => 'posts#edit', as: 'edit_post'
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    get "/assets/font-awesome-sprockets", to: "user#show"
    get '/profile_image.jpg', to: 'users#get_profile_image'
    get 'app/assets/images/LOVE-SHOPPING.png', to: 'path/to/your/controller#action'
    
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :destroy] do
    end
  end

  post '/posts/:id/favorite', to: 'favorites#create', as: 'post_favorite'

end
