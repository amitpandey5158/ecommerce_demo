ActiveAdmin.register User do

  actions :all, except: [:new, :edit]
  remove_filter :created_at, :updated_at, :unconfirmed_email, :confirmation_sent_at, :confirmed_at, :confirmation_token, :last_sign_in_ip, :current_sign_in_ip, :last_sign_in_at, :current_sign_in_at, :ign_in_count, :remember_created_at, :reset_password_sent_at, :reset_password_token, :encrypted_password, :notify_users, :wishlist, :carts

  index do
    column :email
    column :sign_in_count
    column :last_sign_in_at
    column :blocked
    column :orders do |user|
      link_to 'view orders', admin_carts_path(id: user.id)
    end
    column :Block_user do |user|
      if user.blocked
        link_to 'unblock', block_unblock_admin_user_path(user, false), method: :put
      else
        link_to 'block', block_unblock_admin_user_path(user, true), method: :put
      end  
    end
    actions
  end

  member_action :block_unblock, method: :put do
    resource.update(blocked: params[:format])
    redirect_to admin_user_path
  end


  show do
    tabs do
      tab 'cart' do
        attributes_table do
          row :email, input_html: { readonly: true }
          row :sign_in_count, input_html: { readonly: true }
          row :last_sign_in_at, input_html: { readonly: true }
          row :blocked
        end 
      end
      tab 'personal details' do
        table_for user.profile do  
          column "name" do |pd|
            pd.name
          end
          column "contact number" do |pd|
            pd.contact_no
          end
          column "address" do |pd|
            pd.address
          end
          column "state" do |pd|
            pd.state
          end
          column "city" do |pd|
            pd.city
          end
          column "pincode" do |pd|
            pd.pincode
          end
        end
      end  
    end  
  end

  csv do
    column :email
    column :blocked
    column :sign_in_count
  end
  
end
