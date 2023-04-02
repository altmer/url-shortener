Rails.application.routes.draw do
  resources :shortened_urls, only: [:show, :create]
end
