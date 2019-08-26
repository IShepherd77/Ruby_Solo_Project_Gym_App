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
