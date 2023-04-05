class CreateWishlistItems < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlist_items do |t|
      t.integer :product_id
      t.integer :wishlist_id
      t.timestamps
    end
  end
end
