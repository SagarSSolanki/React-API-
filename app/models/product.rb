class Product < ActiveRecord::Base
  has_one :discount
  validates :price, :code, :name, presence: true
  validates :code, :name , uniqueness: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
end
