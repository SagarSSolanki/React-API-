class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products 
  end

  def update 
    product = Product.find_by_id(params[:id])
    
    if product != nil
      if product.update(price: params[:price])
        render json: product
      else
        render json: product.errors, status: 422
      end
    else
      render json: {message: "ID not found!" }, status: 422
    end
  end

  private

  def product_params
    params.require(:product).permit(:price)
  end
end
