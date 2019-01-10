class FriendsParty < ActiveRecord::Base
    belongs_to :friend 
    belongs_to :party   
    
    validates_uniqueness_of :party_id, scope: :friend_id
end