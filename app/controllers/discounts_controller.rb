class DiscountsController < ApplicationController

  def index 
    items = params[:items].split(', ')

    calculate_frequency(items)
    sub_total = calculate_total
    discount = calculate_discount

    render json: { discounted_total: sub_total - discount, sub_total: sub_total, discount: discount }
  end


  private 

  def calculate_frequency(items)
    @item_hash = Hash.new(0)

    for item in items
      @item_hash[item] += 1
    end
  end

  def calculate_total
    total = 0
    @item_hash.each_key do |item|
      product = Product.find_by(code: item)
      total += (@item_hash[item] * product.price) 
    end
    total
  end

  def calculate_discount
    discount = 0
    @item_hash.each_key do |item|
      product = Product.find_by(code: item)
      next if product.discount.blank?
      if @item_hash[item] >= product.discount.quantity
        if product.discount.item?
          discount += item_discount(product)
        elsif product.discount.percent?
          discount += percent_discount(item,product)
        end
      end
    end
    discount
  end

  def percent_discount(item, product)
    temp = (@item_hash[item] * product.price)
    temp * (product.discount.value.to_f / 100)
  end

  def item_discount(product)
    product.discount.value * product.price
  end
end
