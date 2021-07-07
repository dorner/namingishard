Rails.application.routes.draw do

  root 'home#index'
  get 'search', to: 'search#index'
  resources :words, only: [:show, :create] do
    post :add_related_word, on: :member
  end
  resources :word_relations, only: [] do
    post :vote, on: :member
  end
end
