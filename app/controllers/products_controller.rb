class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # Muestra la lista de productos
  def index
    @products = Product.all
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
      redirect_to products_path, notice: 'Producto creado correctamente.'
    else
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
      redirect_to products_path, notice: 'Producto actualizado correctamente.'
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /products/:id
  # Elimina un producto
  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Producto eliminado correctamente.'
  end

  private

  # Busca un producto por ID y lo asigna a @product
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: 'Producto no encontrado.'
  end

  # Filtra los parámetros permitidos para crear/actualizar
  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end
