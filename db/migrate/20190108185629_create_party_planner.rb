class CreatePartyPlanner < ActiveRecord::Migration[5.2]
  def change
    create_table :party_planners do |table|
      table.string :name, null: false

      table.timestamps null: false
    end
  end
end
