# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
PartyPlanner.delete_all
party_planners_attributes = [
    {name: "Louis"},
    {name: "Gil"},
    {name: "Sasha"},
    {name: "Tony"}
]
planner = nil
party_planners_attributes.each do |attributes|
    planner = PartyPlanner.create(attributes)
end

Party.delete_all
parties_attributes = [
    {name: "The Big One", details:"Big party", location:"Big House"},
    {name: "The Small One", details:"It'll be bigger than the big one", location:"'Small' House"}
]

parties_attributes.each do |attributes|
    Party.create(attributes)
end

Friend.delete_all
friends_attributes = [
    {first_name: "Louis", last_name: "Blake", party_planner: planner},
    {first_name: "Frank", last_name: "Sinatra", party_planner: planner}

]

friends_attributes.each do |attributes|
    Friend.create(attributes)
end

FriendsParty.delete_all
friend_party_attributes=[
    {friend: Friend.first, party: Party.first},
    {friend: Friend.last, party: Party.last}
]

friend_party_attributes.each do |attributes|
    FriendsParty.create(attributes)
end