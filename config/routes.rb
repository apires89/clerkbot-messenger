Rails.application.routes.draw do
  resources :rooms
  esources :activities
  resources :bookings
  resources :hostels
  mount Facebook::Messenger::Server, at: "bot"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
