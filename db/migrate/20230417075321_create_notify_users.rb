class CreateNotifyUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :notify_users do |t|
      t.integer :product_id
      t.integer :user_id
      t.boolean :notify, default: true

      t.timestamps
    end
  end
end
