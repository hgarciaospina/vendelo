class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show]

  def edit
    # @product ya está cargado por el before_action
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Producto actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Producto no encontrado."
  end

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end