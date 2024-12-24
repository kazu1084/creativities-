Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions'
  }
  root to: "homes#top"
  devise_for :clients
  devise_for :contractors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about' => 'homes#about',as: 'about'
  get 'homes/job' => 'homes#job' ,as: 'job'
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

  resource :contacts, only: [:new, :create] do
   post 'confirm' => 'contacts#confirm'
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
    resources :clients, only: [:index, :show, :destroy] do
        resources :comments, module: :clients, only: [:index, :destroy]
        resources :bookmarks, module: :clients,only: [:index, :destroy]
        resources :follows, module: :clients,only: [:index, :destroy]
        resources :reviews, module: :clients,only: [:index, :destroy]
        resources :messages, module: :clients,only: [:index, :show, :destroy]
    end
    resources :contractors, only: [:index, :show, :destroy] do
      resources :comments, module: :contractors, only: [:index, :destroy]
      resources :bookmarks, module: :contractors, only: [:index, :destroy]
      resources :follows, module: :contractors, only: [:index, :destroy]
      resources :messages, module: :contractors, only: [:index, :show, :destroy]
    end
    resources :contacts, only: [:index, :show, :destroy]
    resources :posts, only: [:destroy]
  end
end
