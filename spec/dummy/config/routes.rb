Rails.application.routes.draw do
  front_end :dummy

  resources :items, only: [:show]

  mount FrontEndBuilds::Engine, at: '/front-end-builds'
end
