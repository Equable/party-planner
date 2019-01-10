class Party < ActiveRecord::Base
    has_many :friend_parties
    has_many :friends, through: :friend_parties

    belongs_to :party_planner
    validates :party_planner_id, presence: true
end