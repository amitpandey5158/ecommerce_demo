class Product < ApplicationRecord
	validates :name, :description, :stock, :price, :cover, :images, presence: true
	belongs_to :category
	has_one_attached :cover
	has_many_attached :images 
	has_many :product_carts
	has_many :carts, through: :product_carts
	has_many :wishlist_items
	has_many :wishlists, through: :wishlist_items
end
