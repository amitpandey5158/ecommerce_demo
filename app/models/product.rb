class Product < ApplicationRecord

	#validates :description, :stock, :price, :cover, :images, presence: true
	#validates :name, uniqueness: { case_sensitive: false }

	default_scope {where(hide: false)}

	has_one_attached :cover
	has_many_attached :images 

	belongs_to :category
	has_many :product_carts, dependent: :destroy 
	has_many :carts, through: :product_carts
	has_many :wishlist_items, dependent: :destroy 
	has_many :wishlists, through: :wishlist_items
	has_many :notify_users

	belongs_to :admin_user

	after_update :notify_user_after_stock_update, if: :saved_change_to_stock?

	private

	def notify_user_after_stock_update
		UserMailMailer.notify_when_stock_update(self.notify_users.pluck(:user_id), self
    ).deliver_now
    self.notify_users.destroy_all
	end
	
end
