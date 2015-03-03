Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :messages

  get '/chat' => 'chat#chat'   

  root 'messages#index'
end
