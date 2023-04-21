class CreateCategoryCsvs < ActiveRecord::Migration[7.0]
  def change
    create_table :category_csvs do |t|

      t.timestamps
    end
  end
end
