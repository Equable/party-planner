class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |table|
      table.string :first_name, null: false
      table.string :last_name, null: false
      table.belongs_to :party_planner, null: false

      table.timestamps null: false
    end
  end
end
