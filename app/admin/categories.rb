ActiveAdmin.register Category do

  require 'csv'

  permit_params :name, :image

  remove_filter :created_at, :updated_at, :products, :image_attachment, :image_blob 

  action_item :import_csv, only: :index do
    link_to 'Import csv', action: 'import_csv'
  end

  collection_action :import_csv do
    render 'admin/csv/categories/import_csv'
  end

  collection_action :upload_csv, :method=> :post do
    begin   
      if params[:dump].present? && params[:dump][:file].original_filename.last(3) == 'csv'
        csv_file = CategoryCsv.convert_save("category", params[:dump][:file])
        if csv_file[0].present? && csv_file[1].present?
          redirect_to admin_categories_path, notice: "#{csv_file[0]} records added! BUT #{csv_file[1]} "
        else
          redirect_to admin_categories_path, notice: "CSV file uploaded successfully with #{csv_file[0]} records"
        end
      else
        redirect_to import_csv_admin_categories_path, notice: "Selected file format is invalid!"
      end 
    rescue 
      redirect_to import_csv_admin_categories_path, notice: "something went wrong"
    end  
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file 
    end
    f.actions
  end  

  show do
    attributes_table do
      row :name
      row :image do |ad|
        image_tag ad.image , :size => '100x100'
      end
    end
  end

end
