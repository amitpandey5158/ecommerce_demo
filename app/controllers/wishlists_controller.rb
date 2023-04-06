class WishlistsController < ApplicationController

	def show
		@wishlist = Wishlist.find_by(id: params[:id])
	end

	def create
		respond_to do |format|
	    product = Product.find_by(id: params[:product_id])
	    if product.present?
		    @wishlist = Wishlist.find_or_create_by(user_id: current_user.id)
		    @wishlist.wishlist_items.find_or_create_by(product_id: product.id)
		   else
		  	flash[:notice] = "product is not present"
	    	redirect_to root_path
		  end
		end
	end

	def destroy
		respond_to do |format|
			@wishlist = Wishlist.find_by(id: params[:id])
			wishlist_item = @wishlist.wishlist_items.find_by(product_id: params[:product_id])
			wishlist_item.destroy
		end		
	end
	
end
