require('sinatra')
require('sinatra/contrib/all')
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
