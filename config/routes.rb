# Front end
FrontEndBuilds::Engine.routes.draw do
  resources :apps, only: [:index, :show, :create, :edit], path: '/api/apps'

  get '/(*path)', to: 'admin#index'
end

Rails.application.routes.draw do
  namespace :front_end_builds do
    resources :builds, only: [:index, :create]
  end
end
