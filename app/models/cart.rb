class Cart < ApplicationRecord
	
	enum :status, { in_cart: 0, placed: 1, delivered: 2, cancelled: 3 }

	has_many :product_carts, dependent: :destroy
	has_many :products, through: :product_carts
	belongs_to :user

	accepts_nested_attributes_for :product_carts

	after_update :send_delivered_or_cancelled_mail, if: :saved_change_to_status?

	private


	def send_delivered_or_cancelled_mail
		if self.status == "delivered"
			UserMailMailer.delivered_order_confirmation(user, self).deliver_now
		elsif self.status == "cancelled"
			UserMailMailer.cancelled_order_confirmation(user, self).deliver_now
		end	
	end
		
end



#cart.status == "delivered" || cart.status == "cancelled" ? cart.send_delivered_or_cancelled_mail : nil }