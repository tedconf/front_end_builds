Rails.application.routes.draw do
  front_end :dummy

  resources :items, only: [:show]
end
