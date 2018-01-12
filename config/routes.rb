Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feelings, only: [:index]
  resources :checkins, only: [:create, :index]
  resources :users, only: [:create, :show]
end
