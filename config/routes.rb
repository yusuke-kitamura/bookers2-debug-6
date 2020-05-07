Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
  	resources :book_comments,only: [:create,:destroy]
  	resource :favorites,only: [:create,:destroy]
  end

end
