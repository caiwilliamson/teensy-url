Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'urls#index'
  resources :urls, only: [:index, :create, :destroy]

  get '/:slug' => 'urls#show'
end
