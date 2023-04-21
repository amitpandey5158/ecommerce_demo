class UserMailMailer < ApplicationMailer

	def placed_order_confirmation(user, order)
	  @user = user
	  @order = order
	  mail(to: @user.email, subject: "Your Order is Placed")
	end

	def delivered_order_confirmation(user, order)
	  @user = user
	  @order = order
	  mail(to: @user.email, subject: "Your Order is Delivered")
	end

	def cancelled_order_confirmation(user, order)
	  @user = user
	  @order = order
	  # attachments.inline['shirt.jpeg'] = File.read('/home/rails/Downloads/to/shirt.jpeg')
	  # mail(to: @user.email, subject: "Your Order is Delivered") 
	end

  def notify_when_stock_update(user, product)
	  @users = User.where(id:user).pluck(:email)
	  @product = product
		mail(to: @users)
	end


end
