class Category < ApplicationRecord
	validates :name, :image, presence: true
	has_many :products
	has_one_attached :image
end
