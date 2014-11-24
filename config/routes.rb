FrontEndBuilds::Engine.routes.draw do
  resources :apps, only: [:index, :create, :edit], path: '/api/apps'

  get '/(*path)', to: 'admin#index'
end
