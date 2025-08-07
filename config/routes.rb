Rails.application.routes.draw do
  # Mostrar formulario de nuevo producto
  get '/products/new', to: 'products#new', as: :new_product

  # Crear producto - SIN alias duplicado
  post '/products', to: 'products#create'

  # Listar productos - CAMBIAMOS alias para evitar conflicto
  get '/products', to: 'products#index', as: :list_products

  # Mostrar producto individual
  get '/products/:id', to: 'products#show', as: :product
end
