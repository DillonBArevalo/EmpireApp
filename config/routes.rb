Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :new, :show, :create]

  resources :armors # full
  resources :weapons # full
  # resources :armor_types
  resources :characters do #, except: [:edit, :update, :destroy] # full
    resources :obtained_skills, only: [:create, :update]
    resources :equipped_weapons, only: [:create, :destroy]
    resources :obtained_weapons, only: [:destroy]
    resources :obtained_armors, only: [:destroy]
  end

  resources :armor_types, only: [:index, :show]

  resources :inventories, only: [:show, :update]
  resources :damage_types, only: [:index] # describe/display

  resources :character_classes, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :skills, only: [:index, :show]
  resources :weapon_classes, only: [:index, :show]
  resources :weapon_types, only: [:index, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'navigation#home'
end
