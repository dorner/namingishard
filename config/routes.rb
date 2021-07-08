Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "callbacks"
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  root 'home#index'
  get 'search', to: 'search#index'
  resources :words, only: [:show, :create] do
    post :add_related_word, on: :member
  end
  resources :word_relations, only: [] do
    post :vote, on: :member
  end
end
