ActiveAdmin.register Product do
  permit_params :name, :description, :stock, :price, :category_id, :hide, :cover, images: []

  remove_filter :created_at, :updated_at, :notify_users, :cover_attachment, :cover_blob, :images_attachments, :images_blobs, :wishlist_items, :carts, :product_carts, :wishlists

  batch_action :disable do |ids|
    products = Product.where(id: ids)
    products.update_all(hide: true)
    
    redirect_to admin_products_path, notice: "#{products.unscoped.count} products disabled."
  end

  batch_action :enable do |ids|
    products = Product.unscoped.where(id: ids)
    products.update_all(hide: false)
    redirect_to admin_products_path, notice: "#{products.count} products enabled."
  end

  scope :all
  scope :enabled do |products|
    products.where(hide: false)
  end
  scope :disabled do |products|
    products.where(hide: true)
  end

  controller do
    def scoped_collection
      Product.unscoped
    end
  end

  action_item :import_csv, only: :index do
    link_to 'Import csv', action: 'import_csv'
  end

  collection_action :import_csv do
    render 'admin/csv/products/product_import_csv'
  end

  collection_action :upload_csv, :method=> :post do
    begin 
      if params[:dump].present? && params[:dump][:file].original_filename.last(3) == 'csv'
        csv_file = ProductCsv.convert_save("product", params[:dump][:file])
        if csv_file[0].present? && csv_file[1].present?
          redirect_to admin_products_path, notice: "#{csv_file[0]} records added! BUT #{csv_file[1]} "
        else
          redirect_to admin_products_path, notice: "CSV file uploaded successfully with #{csv_file[0]} records"
        end
      else
        redirect_to import_csv_admin_products_path, notice: "Selected file format is invalid!"  
      end 
    rescue 
      redirect_to import_csv_admin_products_path, notice: "something went wrong"
    end     
  end  

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :cover, as: :file, hint: f.object.cover.attached? ? image_tag(f.object.cover) : ''
    end
    f.inputs do
      f.input :images, as: :file,  input_html: {multiple: true }
    end
    f.actions
  end 

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :hide
      row :image do |ad|
        image_tag ad.cover, :size => '100x100'
      end
      row :images do |ad|
        ul do
          ad.images.each do |image|
            li do
              image_tag image, :size => '100x100'
            end  
          end 
        end   
      end
    end
  end
 
end
