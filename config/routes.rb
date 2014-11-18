FrontEndBuilds::Engine.routes.draw do
  get '/', to: 'admin#index'
  
  resources :apps, only: [:create, :edit]
end
