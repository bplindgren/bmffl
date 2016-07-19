Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root 'leagues#show', :id => 1

  resources :users, only: [:new, :create, :show]
  resources :session, only: [:new, :create]
  resources :leagues, only: :show
  resources :seasons, only: :show
  resources :owners, only: :show
  resources :teams, only: [:index, :show]
  resources :games, only: :show
  resources :records, only: :index
  resources :votes, only: :create
  resources :bowerytimes, only: :index

  get 'session/logout' => "session#logout"
  get 'application/session_viewer' => "application#session_viewer"
  get 'application/headtohead' => "application#headtohead"
  get 'application/contact' => "application#contact"
end
