FrontEndBuilds::Engine.routes.draw do
  get '/', to: 'admin#index'
  
  resources :apps, only: [:index, :create, :edit]
end
