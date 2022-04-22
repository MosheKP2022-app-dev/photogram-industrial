Rails.application.routes.draw do
  root to: "photos#index"

  

  devise_for :users
 
  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos

  get ":username/liked" => "photos#liked", as: :liked_photos

  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/:username" => "users#show", as: :user
end
