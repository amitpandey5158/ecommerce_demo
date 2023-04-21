class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :carts, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :notify_users, dependent: :destroy
  
end
