require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/member')
also_reload('./models/*')

get '/members' do
  @members = Member.all
  erb(:'members/show')
end

get '/members/new' do # new
  erb( :'members/new' )
end

post '/members' do # create
  params['dob']=Date.strptime(params['dob'],'%d/%m/%Y')
  params['premium']=params['premium']== 'true'
  @member = Member.new( params )
  @member.save()
  redirect to '/members'
end

get '/members/:id/edit' do # edit
  @member = Member.find( params[:id] )
  # binding.pry
  erb( :'members/edit' )
end

post '/members/:id' do # update /edit
  # binding.pry
  params['dob']=Date.strptime(params['dob'],'%d/%m/%Y')
  params['premium']=params['premium']== 'true'
  Member.new( params ).update
  redirect to '/members'
end

post '/members/:id/delete' do
  member = Member.find(params['id'])
  member.delete
  redirect to '/members'
end

#test comment
