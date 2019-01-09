class Friend < ActiveRecord::Base
     has_many :friend_parties
     has_many :parties, through: :friend_partys

     belongs_to :party_planner

end