class ProductsController < ApplicationController
  before_action :find_product, only: [:update]

  def index
    products = Product.all
    render json: products 
  end

  def update 
      if @product.update(price: params[:price])
        render json: @product
      else
        render json: @product.errors, status: 422
      end
    end

  private

  def find_product 
    @product = Product.find_by_id(params[:id])
    render json: { message: "Product not found with id: #{params[:id]}", status: 422 } if @product.blank?
  end
  
  def product_params
    params.require(:product).permit(:price)
  end
end
