require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/flash'
require "pry" if development? || test?
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

configure do
  set :views, 'app/views'
end

enable :sessions

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

def plannerFriends(id)
  friends= []
  Friend.where("party_planner_id = #{Party.find(id).party_planner_id}").each do |friend|
    friends << friend
  end
  return friends
end

def partyInvites(id)
  invites=[]
  FriendsParty.where("party_id = #{params[:id].to_i}").each do |partyfriends|
    invites << partyfriends
  end
  return invites
end

get '/' do
  redirect '/parties'
end

get '/parties' do
  @parties = Party.all

  erb :'parties/index'
end

get '/parties/new' do
  @party_name=""
  @party_details=''
  @party_location=''
  @planners=PartyPlanner.all
  @planner = PartyPlanner.first
  
  erb :'parties/form'
end

post '/parties/new' do
  @party_name=params['name'].strip
  @party_details=params['details'].strip
  @party_location=params['location'].strip
  @planners=PartyPlanner.all
  @planner = PartyPlanner.find(params['party-planner'].to_i)
  
  
  if @party_name==''||@party_details==''||@party_location==''
    @error = 'Please fill all fields'
    return erb :'parties/form'
  else
    Party.create({name: @party_name, details: @party_details, location: @party_location, party_planner_id: @planner.id})
    flash[:notice] = "Succesfully Submitted Party"
    redirect "/parties/#{Party.last.id}"
  end

end

get '/parties/:id' do
  @party = Party.find(params[:id])
  @invites = partyInvites(params[:id])
  @friends = plannerFriends(params[:id])

  erb :'parties/show'
end

get '/friends' do
  @friends = Friend.order(:first_name) 
  erb :'friends/index'
end

get '/friends/new' do
  @friend_first = ''
  @friend_last = ''
  @planner = PartyPlanner.first.id
  @planners = PartyPlanner.all

  erb :'friends/form'
end

post '/friends/new' do
  @friend_first = params['first_name'].strip
  @friend_last = params['last_name'].strip
  @planner = params['planner']
  @planners = PartyPlanner.all

  if @friend_last==''||@friend_first==''
    @error = 'Please fill all fields'

    erb :'friends/form'
  else
    flash[:notice]="Successfully added friend"
    Friend.create(first_name:@friend_first, last_name: @friend_last, party_planner_id: @planner.to_i)
    redirect '/friends'
  end

end

post '/invite/:id' do
   commit = FriendsParty.create(party_id: params['id'], friend_id: params['to_invite'])
   if commit.valid?
      flash[:notice]= "Friend added"
      redirect "/parties/#{params["id"]}"
   else
    flash[:notice]="Friend already in party list"
    redirect "/parties/#{params["id"]}"
   end

end