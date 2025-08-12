Rails.application.routes.draw do
  resources :categories, except: :show
  resources :products, path: '/'
  # Silenciar solicitudes automáticas de DevTools u otros escaneos
  get '/.well-known/*path', to: proc { [204, {}, ['']] }
end
