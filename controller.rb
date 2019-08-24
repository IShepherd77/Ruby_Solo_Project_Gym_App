require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('models/member')
also_reload('./models/*')

get '/members' do
  @members = Member.all
  erb(:members)
end

post '/members/:id/delete' do
  member = Member.find(params['id'])
  member.delete
  redirect to '/members'
end

get '/members/:id/edit' do # edit
  @member = Member.find( params[:id] )
  #converting database string date to Ruby date object
  @member.dob=(Date.parse(@member.dob))
  binding.pry
  erb( :edit_member )
end
