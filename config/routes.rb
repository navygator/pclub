Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :messages

  get '/chat' => 'messages#chat'   

  root 'messages#index'
end
