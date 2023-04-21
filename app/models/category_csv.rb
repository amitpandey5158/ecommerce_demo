require 'csv'
class CategoryCsv
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
        image_data = attributes.delete("image")
        instance = target_model.new(attributes)
        instance.image.attach(io: File.open(image_data), filename: File.basename(image_data)) if image_data.present?
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
