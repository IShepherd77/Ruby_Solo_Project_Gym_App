require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/lesson')
also_reload('./models/*')

get '/lessons' do #display all lessons find all
  @lessons = Lesson.all
  erb(:'lessons/show')
end

get '/lessons/new' do # new
  erb( :'lessons/new' )
end

get '/lessons/upcoming' do
  @lessons = Lesson.upcoming()
  erb(:'lessons/show')
end

get '/lessons/:id' do
  @lesson = Lesson.find( params[:id] )
  @members = Member.find_by_lesson( params[:id])
  @all_members = Member.all
  erb( :'lessons/show_by_id')
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
  erb( :'lessons/edit' )
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
