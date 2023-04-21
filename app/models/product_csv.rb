require 'csv'
class ProductCsv < ApplicationRecord
	class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      lines = CSV.parse(csv_file)
      header = lines.shift
      failed_instances = []
      count = 0
      notice = ''
      lines.each_with_index do |line, index|
        attributes = Hash[header.zip line]
        target_model = model_name.classify.constantize
        category = Category.find_by("lower(name) = ?", attributes["category"].downcase)
        cover_image = attributes.delete("cover")
        instance = target_model.new(name:attributes["name"], description:attributes["description"], stock:attributes["stock"], price:attributes["price"], category_id: category.id)       
        instance.cover.attach(io: File.open(cover_image), filename: File.basename(cover_image)) if cover_image.present?
      
        images = attributes.delete("images")&.split(",")
        if images.present?
          images.each do |image|
          	instance.images.attach(io: File.open(image), filename: File.basename(image))
          end
        end
        if instance.save
        	count += 1
        else
          failed_instances << { instance: instance, line_number: index + 2 }
        	error_messages = failed_instances.map { |failed_instance| "Line #{failed_instance[:line_number]}: #{failed_instance[:instance].errors.full_messages.join(', ')}"}
        		notice = "Some instances could not be saved: #{error_messages}"
        end    	
      end 
      [count, notice]
    end
  end
end