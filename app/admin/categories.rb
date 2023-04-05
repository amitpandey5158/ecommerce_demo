ActiveAdmin.register Category do

  permit_params :name, :image

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
