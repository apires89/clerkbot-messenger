Rails.application.routes.draw do
resources :rooms
resources :activities
resources :bookings
resources :hostels

  devise_for :users
  root to: 'pages#home'
  mount Facebook::Messenger::Server, at: "bot"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
