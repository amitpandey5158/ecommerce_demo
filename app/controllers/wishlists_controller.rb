class WishlistsController < ApplicationController

	def create
		debugger
    product = Product.find_by(id: params[:product_id])
    if product.present?
	    @wishlist = Wishlist.find_or_create_by(user_id: current_user.id)
	    @wishlist.wishlist_items.find_or_create_by(product_id: product.id)

	  else

	  end
	end

end
