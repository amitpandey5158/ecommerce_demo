class CartsController < ApplicationController

	def show
		@cart = Cart.find_by(id: params[:id])
	end

	def add_product_carts
    product = Product.where('id = ? AND stock > ?', params[:product_id], 0).first
    if product.present?
    	@cart = Cart.find_or_create_by(user_id: current_user.id, status: 'in_cart' )
    	@cart.product_carts.create(product_id: product.id, quantity:1, unit_price: product.price, total_price: product.price)
    	product.update_attribute(:stock, product.stock - 1)
    	update_cart_value
    	redirect_to cart_path(@cart)
    else
    	flash[:notice] = "product is not present"
    	redirect_to root_path
    end	
	end
	
	def destroy
		@cart = Cart.find_by(id: params[:id])
		product_cart = @cart.product_carts.find_by(id: params[:product_cart_id])
		product_cart.destroy
		if @cart.product_carts.empty?
  		redirect_to empty_cart_path(message: "Your cart is now empty.") 
		else
  		redirect_to cart_path(@cart)
		end		
	end

	def update_quantity
		@cart = Cart.find_by(id: params[:id])
		product = Product.find_by(id: params[:product_id])
		product_cart = @cart.product_carts.find_by(product_id: params[:product_id])
		if params[:new_quantity] > params[:old_quantity] && product.stock > 0
			product_cart.update(quantity: params[:new_quantity], total_price: params[:new_quantity].to_i * product_cart.unit_price)
			product.update_attribute(:stock, product.stock - 1)
		elsif
			product_cart.update(quantity: params[:new_quantity], total_price: params[:new_quantity].to_i * product_cart.unit_price)
			product.update_attribute(:stock, product.stock + 1)
		else
			flash[:notice] = "product is not present"
			redirect_to root_path
		end
		update_cart_value
		redirect_to cart_path(@cart) 
	end

	private

	def update_cart_value
		subtotal = @cart.product_carts.sum('total_price')
		if ShippingCharge.first.present? && subtotal < ShippingCharge.first&.total_is_grater_than.to_i
			shipping_charge = ShippingCharge.first.shipping_charge
			@cart.update(subtotal: subtotal, shipping_cost:shipping_charge, total: subtotal + shipping_charge)
		else
		  @cart.update(subtotal: subtotal, shipping_cost: 0, total: subtotal)
		end
	end

end
