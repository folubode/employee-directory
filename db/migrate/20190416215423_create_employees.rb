class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :extension
      t.string :phone

      t.timestamps
    end
  end
end
