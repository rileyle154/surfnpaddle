Rails.application.routes.draw do

  root 'homes#index'

  resources :posts
  resources :users do
    resources :posts
  end

  get '/about' => 'about#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
