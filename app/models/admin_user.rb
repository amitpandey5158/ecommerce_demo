class AdminUser < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  has_many :products       

  enum :role, { admin: 0, delivery_boy: 1, vendor: 2 }       
         
end
