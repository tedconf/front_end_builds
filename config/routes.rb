# This is for the admin area.
FrontEndBuilds::Engine.routes.draw do
  resources :apps, only: [:index, :show, :create, :edit, :destroy]
  resources :builds, only: [:index, :show, :edit]

  get '/(*path)', to: 'admin#index'
end

# This is for the posting of new apps.
Rails.application.routes.draw do
  namespace :front_end_builds do
    resources :builds, only: [:create]
    resource :best, only: [:show]
  end
end
