class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |table|
      table.string :name, null: false
      table.text :details, null: false
      table.string :location, null: false
      table.belongs_to :party_planner, null: false

      table.timestamps null: false
    end
  end
end
