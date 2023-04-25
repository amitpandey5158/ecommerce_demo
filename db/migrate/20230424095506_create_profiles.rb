class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :email
      t.integer :contact_no
      t.text :address
      t.string :state
      t.string :city
      t.integer :user_id
      t.integer :pincode
      
      t.timestamps
    end
  end
end
