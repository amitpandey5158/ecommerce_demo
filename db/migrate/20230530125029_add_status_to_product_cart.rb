class AddStatusToProductCart < ActiveRecord::Migration[7.0]
  def change
    add_column :product_carts, :status, :integer, default: 0
  end
end
