class FriendsParties < ActiveRecord::Migration[5.2]
  def change
    create_table :friends_parties do |table|
      table.belongs_to :friend, null: false
      table.belongs_to :party, null: false
    end
  end
end
