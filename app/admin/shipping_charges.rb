ActiveAdmin.register ShippingCharge do

  permit_params :shipping_charge, :total_is_grater_than

  remove_filter :created_at, :updated_at, :shipping_charge, :total_is_grater_than
 
  controller do
    def action_methods 
      action_method = super
      if ShippingCharge.first.present?
        action_method.delete("new")
      else 
        action_method
      end
    end
  end

end
