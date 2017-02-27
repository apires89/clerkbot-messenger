Rails.application.routes.draw do
resources :rooms
resources :activities
resources :bookings
resources :hostel

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
