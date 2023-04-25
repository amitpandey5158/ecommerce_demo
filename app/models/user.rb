class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :carts, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :notify_users, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_create :create_profile

  private

  def create_profile
    Profile.find_or_create_by(user_id: self.id)
  end
  
end
