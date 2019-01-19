Rails.application.routes.draw do 
  root to: 'tops#index'
  devise_for :users
  resources :shops do
    collection do
      post:confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:show] do
    member do
      get 'favorite'
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
