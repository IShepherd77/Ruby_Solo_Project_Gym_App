require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/booking')
also_reload('./models/*')

post '/bookings' do # create
  @booking = Booking.new( params )
  @booking.save()
  redirect to ('/lessons/' + params['lesson_id'])
end

post '/bookings/:id/delete' do #delete
  booking = Booking.find(params['id'])
  booking.delete
  redirect to '/lessons' + params['lesson_id']
end
