class WishlistItem < ApplicationRecord
	belongs_to :product
	belongs_to :wishlist

	after_destroy :destroy_wishlist_if_no_product_present

	private

	def destroy_wishlist_if_no_product_present
    if wishlist.wishlist_items.empty?
      wishlist.destroy
    end
  end
  
end
