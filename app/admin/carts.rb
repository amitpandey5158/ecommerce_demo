ActiveAdmin.register Cart do
  menu label: "Orders"

  permit_params :status, :subtotal, :total, :shipping_cost, :user_id, :razorpay_order_id, :razorpay_payment_status, :razorpay_payment_id, product_carts_attributes: [:id, :quantity, :unit_price]

  remove_filter :created_at, :updated_at, :product_carts, :products, :user
  
  actions :all, except: [:new, :destroy]

  scope :all
  scope :incart do |carts|
    carts.where(status: 'in_cart')
  end
  scope :placed do |carts|
    carts.where(status: 'placed')
  end
  scope :delivered do |carts|
    carts.where(status: 'delivered')
  end
  scope :cancelled do |carts|
    carts.where(status: 'cancelled')
  end

  form do |f|
    tabs do
      tab 'cart' do
        f.inputs do
          f.input :subtotal, input_html: { readonly: true }
          f.input :total, input_html: { readonly: true }
          f.input :shipping_cost, input_html: { readonly: true }
          f.input :razorpay_order_id, input_html: { readonly: true }
          f.input :razorpay_payment_status, input_html: { readonly: true }
          f.input :razorpay_payment_id, input_html: { readonly: true }
          f.input :status
        end
      end           
      tab 'product cart' do
        f.inputs "Product Carts" do
          f.has_many :product_carts do |pc|
            pc.input 'product name', input_html: { value: pc.object.product&.name, readonly: true }
            pc.input :quantity, input_html: { readonly: true }
            pc.input :unit_price, input_html: { readonly: true }
          end
        end
      end    
    end    
    f.actions
  end

  show do
    tabs do
      tab 'cart' do
        attributes_table do
          row :subtotal
          row :total
          row :shipping_cost
          row :razorpay_order_id
          row :razorpay_payment_status
          row :razorpay_payment_id
          row :status 
        end 
      end
      tab 'product cart' do
        table_for cart.product_carts do
          column "Product" do |pc|
            pc.product&.name
          end
          column "Quantity" do |pc|
            pc.quantity
          end 
          column "Unit Price" do |pc|
            pc.unit_price
          end
          column "Cover image" do |pc|
            image_tag(pc.product.cover, :size => '80x80')
          end
        end
      end  
    end  
  end



  controller do 
    def index
      super do 
        if params[:id]
          user = User.find_by(id: params[:id])
          @carts = user.carts.where.not(status: "in_cart")
        end
      end
    end
  end 


 
end
