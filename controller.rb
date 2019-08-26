require('sinatra')
require('sinatra/contrib/all')
require('pry')
# require_relative('models/member')
require_relative('controllers/members_controller')
require_relative('controllers/lessons_controller')
require_relative('controllers/bookings_controller')
also_reload('./models/*')

get '/' do
  erb (:home)
end
