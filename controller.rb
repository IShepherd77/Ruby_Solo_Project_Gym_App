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

post '/members/:id/delete' do
  member = Member.find(params['id'])
  member.delete
  redirect to '/members'
end

get '/lessons' do #display all lessons find all
  @lessons = Lesson.all
  erb(:lessons)
end

get '/lessons/new' do # new
  erb( :add_lesson )
end

get '/lessons/upcoming' do
  @lessons = Lesson.upcoming()
  erb(:lessons)
end

get '/lessons/:id' do
  @lesson = Lesson.find( params[:id] )
  @members = Member.find_by_lesson( params[:id])
  erb( :view_lesson )
end

post '/lessons' do # create
  date_val = Date.strptime(params['lesson_date'],'%d/%m/%Y')
  params['lesson_date'] = date_val
  params['start_time'] = Time.new(date_val.year, date_val.month, date_val.mday, params['start_hour'].to_i, params['start_min'].to_i)
  @lesson = Lesson.new( params )
  @lesson.save()
  redirect to '/lessons'
end

get '/lessons/:id/edit' do # edit
  @lesson = Lesson.find( params[:id] )
  # binding.pry
  erb( :edit_lesson )
end

post '/lessons/:id' do # update
  date_val = Date.strptime(params['lesson_date'],'%d/%m/%Y')
  params['lesson_date'] = date_val
  params['start_time'] = Time.new(date_val.year, date_val.month, date_val.mday, params['start_hour'].to_i, params['start_min'].to_i)
  Lesson.new( params ).update
  redirect to '/lessons'
end

post '/lessons/:id/delete' do
  lesson = Lesson.find(params['id'])
  lesson.delete
  redirect to '/lessons'
end
