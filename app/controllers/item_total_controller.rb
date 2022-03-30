class ItemTotalController < ApplicationController

  def index
    str = params[:str].split(', ')
    total = 0

    str.each do |item|
      product = Product.find_by(code: item)
      total += product.price 
    end

    render json: {total_price: total}
  end
end
