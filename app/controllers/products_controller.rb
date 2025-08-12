class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # Muestra la lista de productos
  def index
    @categories = Category.all.order(name: :asc).load_async
    @products = Product.all.with_attached_photo.order(created_at: :desc).load_async
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end  
    if params[:min_price].present?
      @products = @products.where("price >=?", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <=?", params[:max_price])
    end

  end

  # GET /products/:id
  # Muestra un producto en detalle
  def show
    # @product ya está cargado por set_product
  end

  # GET /products/new
  # Muestra el formulario para crear un producto nuevo
  def new
    @product = Product.new
  end

  # POST /products
  # Crea un producto en base a los parámetros enviados
  def create
    @product = Product.new(product_params)

    if @product.save
      # Redirige al listado y muestra mensaje de éxito
      redirect_to products_path, notice: t('.created')
    else
      # Si hay errores de validación, renderiza el formulario con estado HTTP 422
      render :new, status: :unprocessable_content
    end
  end

  # GET /products/:id/edit
  # Muestra el formulario de edición de un producto existente
  def edit
    # @product ya está cargado por set_product
  end

  # PATCH/PUT /products/:id
  # Actualiza un producto existente
  def update
    if @product.update(product_params)
      # Redirige al listado y muestra mensaje de éxito
      redirect_to products_path, notice: t('.updated')
    else
      # Si hay errores de validación, renderiza el formulario con estado HTTP 422
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /products/:id
  # Elimina un producto
  def destroy
    # Se elimina el producto cargado por set_product
    # El link de eliminación en la vista debe tener:
    #   data: { turbo_method: :delete, turbo_confirm: "¿Estás seguro de que deseas eliminar este producto?" }
    # Esto asegura que Turbo (Hotwire) muestre el cuadro de confirmación antes de hacer el DELETE
    @product.destroy

    # IMPORTANTE: Rails 8 recomienda status: :see_other para redirecciones tras DELETE
    # Esto evita que Turbo reintente la solicitud DELETE después de la redirección
    # Además, el `notice` se almacenará en `flash` y se mostrará automáticamente en la siguiente carga de página
    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  private

  # Busca un producto por ID y lo asigna a @product
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    # Si no existe el producto, redirige al listado mostrando mensaje de alerta
    redirect_to products_path, alert: 'Producto no encontrado.'
  end

  # Filtra los parámetros permitidos para crear/actualizar
  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
