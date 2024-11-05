Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :clients
  devise_for :contractors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'homes/about' => 'homes#about',as: 'about'
  resources :posts
  resources :clients,only: [:show, :edit, :update] do
    get 'mypage' => 'clients#mypage'
  end

  resources :contractors,only: [:show, :edit, :update] do
    get 'mypage' => 'contractors#mypage'
  end
end
