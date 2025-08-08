Rails.application.routes.draw do
  # Mostrar formulario de nuevo producto
  get '/products/new', to: 'products#new', as: :new_product

  # Crear producto
  post '/products', to: 'products#create'

  # Listar productos
  get '/products', to: 'products#index', as: :list_products

  # Mostrar producto individual
  get '/products/:id', to: 'products#show', as: :product

  # Editar producto
  get '/products/:id/edit', to: 'products#edit', as: :edit_product

  # Actualizar producto (soporte para PATCH y PUT)
  patch '/products/:id', to: 'products#update'
  put   '/products/:id', to: 'products#update'

  # Eliminar producto
  delete '/products/:id', to: 'products#destroy'

  # Silenciar solicitudes automáticas de DevTools u otros escaneos
  get '/.well-known/*path', to: proc { [204, {}, ['']] }
end
