Rails.application.routes.draw do
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
    resources :contractors, only: [] do
      resource :follows, only: [:create, :destroy]
    end
  end
  
  namespace :contractor do
    resources :clients, only: [] do
      resource :follows, only: [:create, :destroy]
    end
  end
end
