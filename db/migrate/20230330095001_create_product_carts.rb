class CreateProductCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :product_carts do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.integer :total_price

      t.timestamps
    end
  end
end
