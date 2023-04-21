ActiveAdmin.register User do

  actions :all, except: [:new, :destroy, :edit]
  remove_filter :created_at, :updated_at, :unconfirmed_email, :confirmation_sent_at, :confirmed_at, :confirmation_token, :last_sign_in_ip, :current_sign_in_ip, :last_sign_in_at, :current_sign_in_at, :ign_in_count, :remember_created_at, :reset_password_sent_at, :reset_password_token, :encrypted_password, :notify_users, :wishlist, :carts

  index do
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :orders do |user|
      link_to 'view orders', admin_carts_path(id: user.id)
    end
    actions
  end

  show do
    attributes_table do
      row :email, input_html: { readonly: true }
      row :sign_in_count, input_html: { readonly: true }
      row :last_sign_in_at, input_html: { readonly: true }
    end
  end  


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  #permit_params :email, :sign_in_count, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at

  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
