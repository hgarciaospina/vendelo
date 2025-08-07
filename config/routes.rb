Rails.application.routes.draw do
  get 'products/new', to: 'products#new', as: :new_product
  get '/products', to: 'products#index', as: :products
  get '/products/:id', to: 'products#show', as: :product 
end
