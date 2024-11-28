Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }
  root to: "homes#top"
  devise_for :clients
  devise_for :contractors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about' => 'homes#about',as: 'about'
  resources :posts,only: [:index, :show, :new, :edit, :create, :destroy, :update] do
      resources :comments,only: [:create,:destroy]
      resources :bookmarks,only: [:create,:destroy]
  end
  resources :clients,only: [:show, :edit, :update] do
    get 'mypage' => 'clients#mypage'
    get 'bookmarks' => 'bookmarks#index', as: 'bookmarks'
    member do
      get :follows
    end
  end

  resources :contractors,only: [:show, :edit, :update] do
    get 'mypage' => 'contractors#mypage'
    get 'bookmarks' => 'bookmarks#index', as: 'bookmarks'
    member do
      get :follows
    end
  end

  namespace :client do
      resources :messages,  only: [:create, :index, :show]
    resources :contractors, only: [] do
      resource :follows, only: [:create, :destroy]
      resource :reviews, only: [:new, :create, :destroy]
      resources :messages, only: [:new]
    end
  end

  namespace :contractor do
    resources :messages, only: [:create,:index, :show]
    resources :contractors, only: [] do
      resources :reviews, only: [:index]
    end
    resources :clients, only: [] do
      resource :follows, only: [:create, :destroy]
      resources :messages, only: [:new]
    end
  end

  namespace :admin do
    root to: "clients#index"
    resources :clients, only: [:index, :destroy]
    resources :contractors, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
