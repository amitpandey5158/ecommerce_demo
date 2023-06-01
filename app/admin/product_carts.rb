ActiveAdmin.register ProductCart do

  permit_params :product_id, :cart_id, :quantity, :unit_price, :total_price, :status

  actions :all, except: [:new, :destroy]

  controller do 
    def index
      super do
        if current_admin_user.role == 'vendor'
          @product_carts = ProductCart.joins(:product).where(products: { admin_user_id: current_admin_user.id })
          @product_carts = collection.page(params[:page]).per(10)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do 
      f.input :product, input_html: { disabled: true }
      f.input :quantity, input_html: { readonly: true }
      f.input :unit_price, input_html: { readonly: true }
      f.input :total_price, input_html: { readonly: true }
      f.input :status
    end
    f.actions
  end

  show do
    attributes_table do
      row :product
      row :quantity
      row :unit_price
      row :total_price
      row :status
    end
  end

end
