class CreateShippingCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_charges do |t|
      t.integer :shipping_charge
      t.integer :total_is_grater_than

      t.timestamps
    end
  end
end
