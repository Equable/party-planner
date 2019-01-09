class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |table|
      table.string :name, null: false
      table.text :details, null: false
      table.string :location, null: false

      table.timestamps null: false
    end
  end
end
