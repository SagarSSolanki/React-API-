class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :discount_type
      t.integer :quantity
      t.integer :value
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
