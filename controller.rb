require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('models/member')
require_relative('models/lesson')
also_reload('./models/*')

get '/members' do
  @members = Member.all
  erb(:members)
end

get '/members/new' do # new
  erb( :add_member )
end

post '/members' do # create
  params['dob']=Date.strptime(params['dob'],'%d/%m/%Y')
  params['premium']=params['premium']== 'true'
  @member = Member.new( params )
  @member.save()
  redirect to '/members'
end

post '/members/:id/delete' do
  member = Member.find(params['id'])
  member.delete
  redirect to '/members'
end

get '/members/:id/edit' do # edit
  @member = Member.find( params[:id] )
  # binding.pry
  erb( :edit_member )
end

post '/members/:id' do # update
  # binding.pry
  params['dob']=Date.strptime(params['dob'],'%d/%m/%Y')
  params['premium']=params['premium']== 'true'
  Member.new( params ).update
  redirect to '/members'
end

get '/lessons' do #display all lessons
  @lessons = Lesson.all
  erb(:lessons)
end
