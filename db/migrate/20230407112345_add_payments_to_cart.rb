class AddPaymentsToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :razorpay_order_id, :string
    add_column :carts, :razorpay_payment_status, :string
    add_column :carts, :razorpay_payment_id, :string
  end
end
