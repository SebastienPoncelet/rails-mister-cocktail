Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'cocktails#index'

  post '/cocktails/random', to: 'cocktails#random', as: :random_cocktail
  get '/cocktails/random', to: 'cocktails#random' # fallback

  post '/cocktails/search', to: 'cocktails#search', as: :search_cocktail

  resources :cocktails do
    resources :doses #, only: [:create, :update, :destroy ]
  end

end
