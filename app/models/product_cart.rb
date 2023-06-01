class ProductCart < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  before_destroy :add_stock_to_product
  after_destroy :destroy_cart_if_no_product_present
  after_update :check_status

  enum :status, { not_delivered: 0, delivered: 1, cancelled: 2 }

  private

  def add_stock_to_product
    product.update_attribute(:stock, product.stock + quantity)   
  end

  def destroy_cart_if_no_product_present
    if cart.product_carts.empty?
      cart.destroy
    end
  end


  def check_status
    if self.cart.product_carts.where.not(status: 'delivered').none?
      self.cart.update(status: 'delivered')
    end
  end

end
 