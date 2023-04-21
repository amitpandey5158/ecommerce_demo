class Category < ApplicationRecord

	validates :image, presence: true
	validates :name, presence: true, uniqueness: true

	has_many :products, dependent: :destroy

	has_one_attached :image
	
end
