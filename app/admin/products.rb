ActiveAdmin.register Product do
  permit_params :name, :description, :stock, :price, :category_id, :cover, images: []

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :cover, as: :file 
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
