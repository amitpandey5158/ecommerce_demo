class CartsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:verify_payment]
	before_action :find_cart, except: [:my_orders, :view_order_detail]

	def show
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
		product_cart = @cart.product_carts.find_by(id: params[:product_cart_id])
		product_cart.destroy
		if @cart.product_carts.empty?
  		redirect_to empty_cart_path(message: "Your cart is now empty.") 
		else
  		redirect_to cart_path(@cart)
		end		
	end

	def update_quantity
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

	def place_order
    receipt = "Order-#{Time.now.to_i}"
	  razorpay_order = Payment::RazorpayPayments.new.create_order(@cart.total, receipt)
    if razorpay_order.status == 'created'
		  @cart.update_columns(razorpay_order_id: razorpay_order.id, razorpay_payment_status: razorpay_order.status)
		else
			flash[:notice] = 'something went wrong'
  	  redirect_to root_path
  	end
		render 'carts/payment', locals: { cart: @cart } and return
	end

	def verify_payment
		res = { razorpay_order_id: params[:razorpay_order_id],
		razorpay_payment_id: params[:razorpay_payment_id],
    razorpay_signature: params[:razorpay_signature] } 
		if Payment::RazorpayPayments.new.verify_payment(res)
			razorpay_payment_id = params[:razorpay_payment_id]
			para_attr = {
    	"amount": @cart.total*100,
    	"currency": "INR"
			}
			capture_status = Payment::RazorpayPayments.new.capture_payment(razorpay_payment_id, para_attr)
			@cart.update_columns(razorpay_payment_id: params[:razorpay_order_id], razorpay_payment_status: 'captured', status: 'placed' )
			UserMailMailer.placed_order_confirmation(current_user, @cart).deliver_now
			flash[:notice] = "payment successfull"
    	redirect_to root_path
		else
			flash[:notice] = "something went wrong"
			redirect_to cart_path(id: @cart.id)
		end
	end

	def my_orders
		@orders = Cart.where.not(status: 'in_cart')
	end

	def view_order_detail
		@view_order = Cart.find_by(id: params[:id])	
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

	def find_cart
		@cart = Cart.find_by(id: params[:id])
	end

end
