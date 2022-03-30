class DiscountsController < ApplicationController

  def index 
    items = params[:items].split(', ')
    total = 0

    item_hash = Hash.new(0)

    for item in items
      item_hash[item] += 1
    end

    item_hash.each_key do |item|
      product = Product.find_by(code: item)
      if item_hash[item] >= product.discount.quantity
        if product.discount.discount_type == "item"
          item_hash[item] = item_hash[item] - product.discount.value
          total += (item_hash[item] * product.price)
        else
          temp = (item_hash[item] * product.price)
          total += (temp - (temp * (product.discount.value.to_f / 100)))
        end
      else
        total += (item_hash[item] * product.price)
      end
    end
    render json: {total_price: total}
  end
end
