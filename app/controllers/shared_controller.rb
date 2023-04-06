class SharedController < ApplicationController

	def empty_cart
		@wishlist_message = params[:message]
	end
	
end
