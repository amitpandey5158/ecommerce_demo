class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :status, default: 0
      t.integer :subtotal
      t.integer :total
      t.integer :shipping_cost

      t.timestamps
    end
  end
end
