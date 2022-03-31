class DiscountsController < ApplicationController

  def index 
    items = params[:items].split(', ')

    calculate_frequency(items)
    sub_total = calculate_total
    discount = calculate_discount

    render json: { Discounted_total: sub_total - discount, Sub_total: sub_total, Discount: discount }
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
      @product = Product.find_by(code: item)
      next if @product.discount.blank?
      if @item_hash[item] >= @product.discount.quantity
        if @product.discount.discount_type == "item"
          discount += item_discount
        else
          discount += percent_discount(item)
        end
      end
    end
    discount
  end

  def percent_discount(item)
    temp = (@item_hash[item] * @product.price)
    temp * (@product.discount.value.to_f / 100)
  end

  def item_discount
    @product.discount.value * @product.price
  end
end
