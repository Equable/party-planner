class Party < ActiveRecord::Base
    has_many :friend_parties
    has_many :friends, through: :friend_parties
end