class CreateProductCsvs < ActiveRecord::Migration[7.0]
  def change
    create_table :product_csvs do |t|

      t.timestamps
    end
  end
end
