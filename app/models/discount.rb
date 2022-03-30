class Discount < ActiveRecord::Base
  belongs_to :product

  validates :quantity, :code, :value, :discount_type, presence: true
  validates :code, uniqueness: true
  validates :value, :numericality => { :greater_than => 0 }

  enum discount_type: [:item,:percent]
end
