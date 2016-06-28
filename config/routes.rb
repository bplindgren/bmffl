Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
  root 'leagues#show', :id => 1

  resources :leagues, :only => :show
  resources :seasons, :only => [:index, :show]
  resources :owners, :only => [:index, :show]
  resources :teams, :only => [:index, :show]
  resources :games, :only => [:show]
end
