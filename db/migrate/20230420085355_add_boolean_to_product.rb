class AddBooleanToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :hide, :boolean, default: false
  end
end
