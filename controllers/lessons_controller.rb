require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/lesson')
also_reload('./models/*')

get '/lessons' do #display all lessons find all
  @lessons = Lesson.all
  erb(:'lessons/show')
end

get '/lessons/new' do # new - loads blank registration page
  erb( :'lessons/new' )
end

get '/lessons/upcoming' do #loads classes in next 24hrs page
  @lessons = Lesson.upcoming()
  erb(:'lessons/show')
end

get '/lessons/:id' do #:id is lesson number in db e.g 1 = Dodgeball
  @lesson = Lesson.find( params[:id] ) #find all lessons in class
  @members = Member.find_by_lesson( params[:id]) #list members on lesson
  @all_members = Member.all #list all current members for dropdown to add to lesson
  erb( :'lessons/show_by_id')#display lessons show_by_id erb page html
end

post '/lessons' do # create
  date_val = Date.strptime(params['lesson_date'],'%d/%m/%Y') #formats date to dd/mm/yyyy. ['lesson_date'] is hash key but returns value
  params['lesson_date'] = date_val
  params['start_time'] = Time.new(date_val.year, date_val.month, date_val.mday, params['start_hour'].to_i, params['start_min'].to_i)
  @lesson = Lesson.new( params )
  @lesson.save()
  redirect to '/lessons'
end

get '/lessons/:id/edit' do # edit
  @lesson = Lesson.find( params[:id] )#finds lesson by db id
  # binding.pry
  erb( :'lessons/edit' ) #displays lesson edit erb file layout
end

post '/lessons/:id' do # update - lessons controller file
  date_val = Date.strptime(params['lesson_date'],'%d/%m/%Y')
  params['lesson_date'] = date_val
  params['start_time'] = Time.new(date_val.year, date_val.month, date_val.mday, params['start_hour'].to_i, params['start_min'].to_i)
  Lesson.new( params ).update
  redirect to '/lessons'
end

post '/lessons/:id/delete' do #delete
  lesson = Lesson.find(params['id'])
  lesson.delete
  redirect to '/lessons'
end
