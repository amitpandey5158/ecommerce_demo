class Cart < ApplicationRecord
	has_many :product_carts
	has_many :products, through: :product_carts
	enum :status, { in_cart: 0, placed: 1, cancelled: 2 }
	belongs_to :user

end
