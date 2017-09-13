Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :show, :create]

  resources :armors #, except: [:edit, :update, :destroy] # full
  resources :weapons # full
  # resources :armor_types
  resources :characters do #, except: [:edit, :update, :destroy] # full
    resources :inventories, only: [:show]
    resources :obtained_skills, only: [:create, :update]
  end

  resources :damage_resistances, only: [:index] # describe dr?
  resources :damage_types, only: [:index] # describe/display

  resources :character_classes, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :skills, only: [:index, :show]
  resources :weapon_classes, only: [:index, :show]
  resources :weapon_types, only: [:index, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'users#new'
end
