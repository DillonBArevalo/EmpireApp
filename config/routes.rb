Rails.application.routes.draw do

  # navigation
  get '/navigation', to: 'navigation#dropdown'
  get '/sub-nav', to: 'navigation#sub_nav'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :new, :show, :create]

  resources :armors # full
  resources :weapons do
    resources :attack_options, only: [:new, :create, :edit, :update]
  end

  get '/weapons/new/shield', to: 'weapons#new_shield'
  get '/weapons/:id/edit/shield', to: 'weapons#edit_shield'

  # resources :armor_types
  resources :characters do #, except: [:edit, :update, :destroy] # full
    resources :obtained_skills, only: [:create, :update]
    resources :equipped_weapons, only: [:create, :destroy]
    resources :obtained_weapons, only: [:create]
    resources :obtained_armors, only: [:create]
  end

  resources :armor_types, only: [:index, :show]

  resources :obtained_armors, only: [:destroy]
  resources :obtained_weapons, only: [:destroy]

  resources :inventories, only: [:show, :update]
  resources :damage_types, only: [:index] # describe/display

  resources :character_classes, only: [:index, :show]
  resources :obtained_classes, only: [:create]
  resources :conditions, only: [:index, :show]
  resources :skills, only: [:index, :show]
  resources :weapon_classes, only: [:index, :show]
  resources :weapon_types, only: [:index, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'navigation#home'
end
