Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: "bot"
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  resources :pages, only: [ :update ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
