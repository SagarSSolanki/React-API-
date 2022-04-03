class Discount < ActiveRecord::Base
  belongs_to :product
  enum discount_type: [:item,:percent]

  validates :quantity, :value, :discount_type, presence: true
  validates :value, :numericality => { :greater_than => 0 }, if: :item?
  validates :value, presence: :true, inclusion: 0..100, if: :percent?
  
end
